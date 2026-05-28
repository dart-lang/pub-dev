// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package main

import (
	"crypto"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"io"
	"os"
	"slices"
)

func main() {
	var pubKeyPath, sigPath, inPath string

	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Usage: <binary> dgst -sha256 -verify <pubKey.pem> -signature <sig.sign> <input.txt>")
		os.Exit(1)
	}
	if os.Args[1] != "dgst" {
		fmt.Fprintln(os.Stderr, "Usage: <binary> dgst -sha256 -verify <pubKey.pem> -signature <sig.sign> <input.txt>")
		os.Exit(1)
	}
	if !slices.Contains(os.Args, "-sha256") {
		fmt.Fprintln(os.Stderr, "Usage: <binary> dgst -sha256 -verify <pubKey.pem> -signature <sig.sign> <input.txt>")
		os.Exit(1)
	}

	// Basic parser to mimic the specific OpenSSL flags passed by the Dart code:
	// openssl dgst -sha256 -verify <pubKey> -signature <sig> <input>
	for i := 2; i < len(os.Args); i++ {
		arg := os.Args[i]
		switch arg {
		case "-sha256":
			continue
		case "-verify":
			i++
			if i < len(os.Args) {
				pubKeyPath = os.Args[i]
			}
		case "-signature":
			i++
			if i < len(os.Args) {
				sigPath = os.Args[i]
			}
		default:
			// The remaining un-flagged argument is the input text file.
			inPath = arg
		}
	}

	if pubKeyPath == "" || sigPath == "" || inPath == "" {
		fmt.Fprintln(os.Stderr, "Usage: <binary> dgst -sha256 -verify <pubKey.pem> -signature <sig.sign> <input.txt>")
		os.Exit(1)
	}

	// 1. Read and decode the PEM Public Key
	pubKeyBytes, err := os.ReadFile(pubKeyPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading public key: %v\n", err)
		os.Exit(1)
	}

	block, _ := pem.Decode(pubKeyBytes)
	if block == nil {
		fmt.Fprintln(os.Stderr, "Error: Failed to parse PEM block")
		os.Exit(1)
	}

	// Try parsing as PKIX (Standard OpenSSL PEM format for public keys)
	pub, err := x509.ParsePKIXPublicKey(block.Bytes)
	if err != nil {
		// Fallback to PKCS1 if necessary
		pub, err = x509.ParsePKCS1PublicKey(block.Bytes)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error parsing public key: %v\n", err)
			os.Exit(1)
		}
	}

	rsaPub, ok := pub.(*rsa.PublicKey)
	if !ok {
		fmt.Fprintln(os.Stderr, "Error: Key type is not RSA")
		os.Exit(1)
	}

	// 2. Read the input file and calculate the SHA-256 hash
	inFile, err := os.Open(inPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error opening input file: %v\n", err)
		os.Exit(1)
	}
	defer inFile.Close()

	h := sha256.New()
	if _, err := io.Copy(h, inFile); err != nil {
		fmt.Fprintf(os.Stderr, "Error hashing input file: %v\n", err)
		os.Exit(1)
	}
	hashed := h.Sum(nil)

	// 3. Read the raw binary signature
	sigBytes, err := os.ReadFile(sigPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading signature file: %v\n", err)
		os.Exit(1)
	}

	// 4. Verify the PKCS1v1.5 RSA Signature
	err = rsa.VerifyPKCS1v15(rsaPub, crypto.SHA256, hashed, sigBytes)
	if err != nil {
		// The Dart code looks specifically for this exact string for failure
		fmt.Println("Verification Failure")
		os.Exit(1)
	}

	// The Dart code looks specifically for this exact string for success
	fmt.Println("Verified OK")
	os.Exit(0)
}
