// This is a generated file (see the discoveryapis_generator project).

library googleapis.vision.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client vision/v1';

/**
 * Integrates Google Vision features, including image labeling, face, logo, and
 * landmark detection, optical character recognition (OCR), and detection of
 * explicit content, into applications.
 */
class VisionApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";


  final commons.ApiRequester _requester;

  ImagesResourceApi get images => new ImagesResourceApi(_requester);

  VisionApi(http.Client client, {core.String rootUrl: "https://vision.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ImagesResourceApi {
  final commons.ApiRequester _requester;

  ImagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Run image detection and annotation for a batch of images.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [BatchAnnotateImagesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BatchAnnotateImagesResponse> annotate(BatchAnnotateImagesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/images:annotate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BatchAnnotateImagesResponse.fromJson(data));
  }

}



/**
 * Request for performing Google Cloud Vision API tasks over a user-provided
 * image, with user-requested features.
 */
class AnnotateImageRequest {
  /** Requested features. */
  core.List<Feature> features;
  /** The image to be processed. */
  Image image;
  /** Additional context that may accompany the image. */
  ImageContext imageContext;

  AnnotateImageRequest();

  AnnotateImageRequest.fromJson(core.Map _json) {
    if (_json.containsKey("features")) {
      features = _json["features"].map((value) => new Feature.fromJson(value)).toList();
    }
    if (_json.containsKey("image")) {
      image = new Image.fromJson(_json["image"]);
    }
    if (_json.containsKey("imageContext")) {
      imageContext = new ImageContext.fromJson(_json["imageContext"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (features != null) {
      _json["features"] = features.map((value) => (value).toJson()).toList();
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (imageContext != null) {
      _json["imageContext"] = (imageContext).toJson();
    }
    return _json;
  }
}

/** Response to an image annotation request. */
class AnnotateImageResponse {
  /** If present, crop hints have completed successfully. */
  CropHintsAnnotation cropHintsAnnotation;
  /**
   * If set, represents the error message for the operation.
   * Note that filled-in image annotations are guaranteed to be
   * correct, even when `error` is set.
   */
  Status error;
  /** If present, face detection has completed successfully. */
  core.List<FaceAnnotation> faceAnnotations;
  /**
   * If present, text (OCR) detection or document (OCR) text detection has
   * completed successfully.
   * This annotation provides the structural hierarchy for the OCR detected
   * text.
   */
  TextAnnotation fullTextAnnotation;
  /** If present, image properties were extracted successfully. */
  ImageProperties imagePropertiesAnnotation;
  /** If present, label detection has completed successfully. */
  core.List<EntityAnnotation> labelAnnotations;
  /** If present, landmark detection has completed successfully. */
  core.List<EntityAnnotation> landmarkAnnotations;
  /** If present, logo detection has completed successfully. */
  core.List<EntityAnnotation> logoAnnotations;
  /** If present, safe-search annotation has completed successfully. */
  SafeSearchAnnotation safeSearchAnnotation;
  /** If present, text (OCR) detection has completed successfully. */
  core.List<EntityAnnotation> textAnnotations;
  /** If present, web detection has completed successfully. */
  WebDetection webDetection;

  AnnotateImageResponse();

  AnnotateImageResponse.fromJson(core.Map _json) {
    if (_json.containsKey("cropHintsAnnotation")) {
      cropHintsAnnotation = new CropHintsAnnotation.fromJson(_json["cropHintsAnnotation"]);
    }
    if (_json.containsKey("error")) {
      error = new Status.fromJson(_json["error"]);
    }
    if (_json.containsKey("faceAnnotations")) {
      faceAnnotations = _json["faceAnnotations"].map((value) => new FaceAnnotation.fromJson(value)).toList();
    }
    if (_json.containsKey("fullTextAnnotation")) {
      fullTextAnnotation = new TextAnnotation.fromJson(_json["fullTextAnnotation"]);
    }
    if (_json.containsKey("imagePropertiesAnnotation")) {
      imagePropertiesAnnotation = new ImageProperties.fromJson(_json["imagePropertiesAnnotation"]);
    }
    if (_json.containsKey("labelAnnotations")) {
      labelAnnotations = _json["labelAnnotations"].map((value) => new EntityAnnotation.fromJson(value)).toList();
    }
    if (_json.containsKey("landmarkAnnotations")) {
      landmarkAnnotations = _json["landmarkAnnotations"].map((value) => new EntityAnnotation.fromJson(value)).toList();
    }
    if (_json.containsKey("logoAnnotations")) {
      logoAnnotations = _json["logoAnnotations"].map((value) => new EntityAnnotation.fromJson(value)).toList();
    }
    if (_json.containsKey("safeSearchAnnotation")) {
      safeSearchAnnotation = new SafeSearchAnnotation.fromJson(_json["safeSearchAnnotation"]);
    }
    if (_json.containsKey("textAnnotations")) {
      textAnnotations = _json["textAnnotations"].map((value) => new EntityAnnotation.fromJson(value)).toList();
    }
    if (_json.containsKey("webDetection")) {
      webDetection = new WebDetection.fromJson(_json["webDetection"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cropHintsAnnotation != null) {
      _json["cropHintsAnnotation"] = (cropHintsAnnotation).toJson();
    }
    if (error != null) {
      _json["error"] = (error).toJson();
    }
    if (faceAnnotations != null) {
      _json["faceAnnotations"] = faceAnnotations.map((value) => (value).toJson()).toList();
    }
    if (fullTextAnnotation != null) {
      _json["fullTextAnnotation"] = (fullTextAnnotation).toJson();
    }
    if (imagePropertiesAnnotation != null) {
      _json["imagePropertiesAnnotation"] = (imagePropertiesAnnotation).toJson();
    }
    if (labelAnnotations != null) {
      _json["labelAnnotations"] = labelAnnotations.map((value) => (value).toJson()).toList();
    }
    if (landmarkAnnotations != null) {
      _json["landmarkAnnotations"] = landmarkAnnotations.map((value) => (value).toJson()).toList();
    }
    if (logoAnnotations != null) {
      _json["logoAnnotations"] = logoAnnotations.map((value) => (value).toJson()).toList();
    }
    if (safeSearchAnnotation != null) {
      _json["safeSearchAnnotation"] = (safeSearchAnnotation).toJson();
    }
    if (textAnnotations != null) {
      _json["textAnnotations"] = textAnnotations.map((value) => (value).toJson()).toList();
    }
    if (webDetection != null) {
      _json["webDetection"] = (webDetection).toJson();
    }
    return _json;
  }
}

/**
 * Multiple image annotation requests are batched into a single service call.
 */
class BatchAnnotateImagesRequest {
  /** Individual image annotation requests for this batch. */
  core.List<AnnotateImageRequest> requests;

  BatchAnnotateImagesRequest();

  BatchAnnotateImagesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("requests")) {
      requests = _json["requests"].map((value) => new AnnotateImageRequest.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (requests != null) {
      _json["requests"] = requests.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Response to a batch image annotation request. */
class BatchAnnotateImagesResponse {
  /** Individual responses to image annotation requests within the batch. */
  core.List<AnnotateImageResponse> responses;

  BatchAnnotateImagesResponse();

  BatchAnnotateImagesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("responses")) {
      responses = _json["responses"].map((value) => new AnnotateImageResponse.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (responses != null) {
      _json["responses"] = responses.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Logical element on the page. */
class Block {
  /**
   * Detected block type (text, image etc) for this block.
   * Possible string values are:
   * - "UNKNOWN" : Unknown block type.
   * - "TEXT" : Regular text block.
   * - "TABLE" : Table block.
   * - "PICTURE" : Image block.
   * - "RULER" : Horizontal/vertical line box.
   * - "BARCODE" : Barcode block.
   */
  core.String blockType;
  /**
   * The bounding box for the block.
   * The vertices are in the order of top-left, top-right, bottom-right,
   * bottom-left. When a rotation of the bounding box is detected the rotation
   * is represented as around the top-left corner as defined when the text is
   * read in the 'natural' orientation.
   * For example:
   *   * when the text is horizontal it might look like:
   *      0----1
   *      |    |
   *      3----2
   *   * when it's rotated 180 degrees around the top-left corner it becomes:
   *      2----3
   *      |    |
   *      1----0
   *   and the vertice order will still be (0, 1, 2, 3).
   */
  BoundingPoly boundingBox;
  /** List of paragraphs in this block (if this blocks is of type text). */
  core.List<Paragraph> paragraphs;
  /** Additional information detected for the block. */
  TextProperty property;

  Block();

  Block.fromJson(core.Map _json) {
    if (_json.containsKey("blockType")) {
      blockType = _json["blockType"];
    }
    if (_json.containsKey("boundingBox")) {
      boundingBox = new BoundingPoly.fromJson(_json["boundingBox"]);
    }
    if (_json.containsKey("paragraphs")) {
      paragraphs = _json["paragraphs"].map((value) => new Paragraph.fromJson(value)).toList();
    }
    if (_json.containsKey("property")) {
      property = new TextProperty.fromJson(_json["property"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blockType != null) {
      _json["blockType"] = blockType;
    }
    if (boundingBox != null) {
      _json["boundingBox"] = (boundingBox).toJson();
    }
    if (paragraphs != null) {
      _json["paragraphs"] = paragraphs.map((value) => (value).toJson()).toList();
    }
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    return _json;
  }
}

/** A bounding polygon for the detected image annotation. */
class BoundingPoly {
  /** The bounding polygon vertices. */
  core.List<Vertex> vertices;

  BoundingPoly();

  BoundingPoly.fromJson(core.Map _json) {
    if (_json.containsKey("vertices")) {
      vertices = _json["vertices"].map((value) => new Vertex.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (vertices != null) {
      _json["vertices"] = vertices.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Represents a color in the RGBA color space. This representation is designed
 * for simplicity of conversion to/from color representations in various
 * languages over compactness; for example, the fields of this representation
 * can be trivially provided to the constructor of "java.awt.Color" in Java; it
 * can also be trivially provided to UIColor's "+colorWithRed:green:blue:alpha"
 * method in iOS; and, with just a little work, it can be easily formatted into
 * a CSS "rgba()" string in JavaScript, as well. Here are some examples:
 *
 * Example (Java):
 *
 *      import com.google.type.Color;
 *
 *      // ...
 *      public static java.awt.Color fromProto(Color protocolor) {
 *        float alpha = protocolor.hasAlpha()
 *            ? protocolor.getAlpha().getValue()
 *            : 1.0;
 *
 *        return new java.awt.Color(
 *            protocolor.getRed(),
 *            protocolor.getGreen(),
 *            protocolor.getBlue(),
 *            alpha);
 *      }
 *
 *      public static Color toProto(java.awt.Color color) {
 *        float red = (float) color.getRed();
 *        float green = (float) color.getGreen();
 *        float blue = (float) color.getBlue();
 *        float denominator = 255.0;
 *        Color.Builder resultBuilder =
 *            Color
 *                .newBuilder()
 *                .setRed(red / denominator)
 *                .setGreen(green / denominator)
 *                .setBlue(blue / denominator);
 *        int alpha = color.getAlpha();
 *        if (alpha != 255) {
 *          result.setAlpha(
 *              FloatValue
 *                  .newBuilder()
 *                  .setValue(((float) alpha) / denominator)
 *                  .build());
 *        }
 *        return resultBuilder.build();
 *      }
 *      // ...
 *
 * Example (iOS / Obj-C):
 *
 *      // ...
 *      static UIColor* fromProto(Color* protocolor) {
 *         float red = [protocolor red];
 *         float green = [protocolor green];
 *         float blue = [protocolor blue];
 *         FloatValue* alpha_wrapper = [protocolor alpha];
 *         float alpha = 1.0;
 *         if (alpha_wrapper != nil) {
 *           alpha = [alpha_wrapper value];
 *         }
 *         return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
 *      }
 *
 *      static Color* toProto(UIColor* color) {
 *          CGFloat red, green, blue, alpha;
 *          if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) {
 *            return nil;
 *          }
 *          Color* result = [Color alloc] init];
 *          [result setRed:red];
 *          [result setGreen:green];
 *          [result setBlue:blue];
 *          if (alpha <= 0.9999) {
 *            [result setAlpha:floatWrapperWithValue(alpha)];
 *          }
 *          [result autorelease];
 *          return result;
 *     }
 *     // ...
 *
 *  Example (JavaScript):
 *
 *     // ...
 *
 *     var protoToCssColor = function(rgb_color) {
 *        var redFrac = rgb_color.red || 0.0;
 *        var greenFrac = rgb_color.green || 0.0;
 *        var blueFrac = rgb_color.blue || 0.0;
 *        var red = Math.floor(redFrac * 255);
 *        var green = Math.floor(greenFrac * 255);
 *        var blue = Math.floor(blueFrac * 255);
 *
 *        if (!('alpha' in rgb_color)) {
 *           return rgbToCssColor_(red, green, blue);
 *        }
 *
 *        var alphaFrac = rgb_color.alpha.value || 0.0;
 *        var rgbParams = [red, green, blue].join(',');
 *        return ['rgba(', rgbParams, ',', alphaFrac, ')'].join('');
 *     };
 *
 *     var rgbToCssColor_ = function(red, green, blue) {
 *       var rgbNumber = new Number((red << 16) | (green << 8) | blue);
 *       var hexString = rgbNumber.toString(16);
 *       var missingZeros = 6 - hexString.length;
 *       var resultBuilder = ['#'];
 *       for (var i = 0; i < missingZeros; i++) {
 *          resultBuilder.push('0');
 *       }
 *       resultBuilder.push(hexString);
 *       return resultBuilder.join('');
 *     };
 *
 *     // ...
 */
class Color {
  /**
   * The fraction of this color that should be applied to the pixel. That is,
   * the final pixel color is defined by the equation:
   *
   *   pixel color = alpha * (this color) + (1.0 - alpha) * (background color)
   *
   * This means that a value of 1.0 corresponds to a solid color, whereas
   * a value of 0.0 corresponds to a completely transparent color. This
   * uses a wrapper message rather than a simple float scalar so that it is
   * possible to distinguish between a default value and the value being unset.
   * If omitted, this color object is to be rendered as a solid color
   * (as if the alpha value had been explicitly given with a value of 1.0).
   */
  core.double alpha;
  /** The amount of blue in the color as a value in the interval [0, 1]. */
  core.double blue;
  /** The amount of green in the color as a value in the interval [0, 1]. */
  core.double green;
  /** The amount of red in the color as a value in the interval [0, 1]. */
  core.double red;

  Color();

  Color.fromJson(core.Map _json) {
    if (_json.containsKey("alpha")) {
      alpha = _json["alpha"];
    }
    if (_json.containsKey("blue")) {
      blue = _json["blue"];
    }
    if (_json.containsKey("green")) {
      green = _json["green"];
    }
    if (_json.containsKey("red")) {
      red = _json["red"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alpha != null) {
      _json["alpha"] = alpha;
    }
    if (blue != null) {
      _json["blue"] = blue;
    }
    if (green != null) {
      _json["green"] = green;
    }
    if (red != null) {
      _json["red"] = red;
    }
    return _json;
  }
}

/**
 * Color information consists of RGB channels, score, and the fraction of
 * the image that the color occupies in the image.
 */
class ColorInfo {
  /** RGB components of the color. */
  Color color;
  /**
   * The fraction of pixels the color occupies in the image.
   * Value in range [0, 1].
   */
  core.double pixelFraction;
  /** Image-specific score for this color. Value in range [0, 1]. */
  core.double score;

  ColorInfo();

  ColorInfo.fromJson(core.Map _json) {
    if (_json.containsKey("color")) {
      color = new Color.fromJson(_json["color"]);
    }
    if (_json.containsKey("pixelFraction")) {
      pixelFraction = _json["pixelFraction"];
    }
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (color != null) {
      _json["color"] = (color).toJson();
    }
    if (pixelFraction != null) {
      _json["pixelFraction"] = pixelFraction;
    }
    if (score != null) {
      _json["score"] = score;
    }
    return _json;
  }
}

/**
 * Single crop hint that is used to generate a new crop when serving an image.
 */
class CropHint {
  /**
   * The bounding polygon for the crop region. The coordinates of the bounding
   * box are in the original image's scale, as returned in `ImageParams`.
   */
  BoundingPoly boundingPoly;
  /** Confidence of this being a salient region.  Range [0, 1]. */
  core.double confidence;
  /**
   * Fraction of importance of this salient region with respect to the original
   * image.
   */
  core.double importanceFraction;

  CropHint();

  CropHint.fromJson(core.Map _json) {
    if (_json.containsKey("boundingPoly")) {
      boundingPoly = new BoundingPoly.fromJson(_json["boundingPoly"]);
    }
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("importanceFraction")) {
      importanceFraction = _json["importanceFraction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boundingPoly != null) {
      _json["boundingPoly"] = (boundingPoly).toJson();
    }
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (importanceFraction != null) {
      _json["importanceFraction"] = importanceFraction;
    }
    return _json;
  }
}

/**
 * Set of crop hints that are used to generate new crops when serving images.
 */
class CropHintsAnnotation {
  /** Crop hint results. */
  core.List<CropHint> cropHints;

  CropHintsAnnotation();

  CropHintsAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("cropHints")) {
      cropHints = _json["cropHints"].map((value) => new CropHint.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cropHints != null) {
      _json["cropHints"] = cropHints.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Parameters for crop hints annotation request. */
class CropHintsParams {
  /**
   * Aspect ratios in floats, representing the ratio of the width to the height
   * of the image. For example, if the desired aspect ratio is 4/3, the
   * corresponding float value should be 1.33333.  If not specified, the
   * best possible crop is returned. The number of provided aspect ratios is
   * limited to a maximum of 16; any aspect ratios provided after the 16th are
   * ignored.
   */
  core.List<core.double> aspectRatios;

  CropHintsParams();

  CropHintsParams.fromJson(core.Map _json) {
    if (_json.containsKey("aspectRatios")) {
      aspectRatios = _json["aspectRatios"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aspectRatios != null) {
      _json["aspectRatios"] = aspectRatios;
    }
    return _json;
  }
}

/** Detected start or end of a structural component. */
class DetectedBreak {
  /** True if break prepends the element. */
  core.bool isPrefix;
  /**
   * Detected break type.
   * Possible string values are:
   * - "UNKNOWN" : Unknown break label type.
   * - "SPACE" : Regular space.
   * - "SURE_SPACE" : Sure space (very wide).
   * - "EOL_SURE_SPACE" : Line-wrapping break.
   * - "HYPHEN" : End-line hyphen that is not present in text; does
   * - "LINE_BREAK" : not co-occur with SPACE, LEADER_SPACE, or
   * LINE_BREAK.
   * Line break that ends a paragraph.
   */
  core.String type;

  DetectedBreak();

  DetectedBreak.fromJson(core.Map _json) {
    if (_json.containsKey("isPrefix")) {
      isPrefix = _json["isPrefix"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (isPrefix != null) {
      _json["isPrefix"] = isPrefix;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Detected language for a structural component. */
class DetectedLanguage {
  /** Confidence of detected language. Range [0, 1]. */
  core.double confidence;
  /**
   * The BCP-47 language code, such as "en-US" or "sr-Latn". For more
   * information, see
   * http://www.unicode.org/reports/tr35/#Unicode_locale_identifier.
   */
  core.String languageCode;

  DetectedLanguage();

  DetectedLanguage.fromJson(core.Map _json) {
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    return _json;
  }
}

/** Set of dominant colors and their corresponding scores. */
class DominantColorsAnnotation {
  /** RGB color values with their score and pixel fraction. */
  core.List<ColorInfo> colors;

  DominantColorsAnnotation();

  DominantColorsAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("colors")) {
      colors = _json["colors"].map((value) => new ColorInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (colors != null) {
      _json["colors"] = colors.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Set of detected entity features. */
class EntityAnnotation {
  /**
   * Image region to which this entity belongs. Currently not produced
   * for `LABEL_DETECTION` features. For `TEXT_DETECTION` (OCR), `boundingPoly`s
   * are produced for the entire text detected in an image region, followed by
   * `boundingPoly`s for each word within the detected text.
   */
  BoundingPoly boundingPoly;
  /**
   * The accuracy of the entity detection in an image.
   * For example, for an image in which the "Eiffel Tower" entity is detected,
   * this field represents the confidence that there is a tower in the query
   * image. Range [0, 1].
   */
  core.double confidence;
  /** Entity textual description, expressed in its `locale` language. */
  core.String description;
  /**
   * The language code for the locale in which the entity textual
   * `description` is expressed.
   */
  core.String locale;
  /**
   * The location information for the detected entity. Multiple
   * `LocationInfo` elements can be present because one location may
   * indicate the location of the scene in the image, and another location
   * may indicate the location of the place where the image was taken.
   * Location information is usually present for landmarks.
   */
  core.List<LocationInfo> locations;
  /**
   * Opaque entity ID. Some IDs may be available in
   * [Google Knowledge Graph Search
   * API](https://developers.google.com/knowledge-graph/).
   */
  core.String mid;
  /**
   * Some entities may have optional user-supplied `Property` (name/value)
   * fields, such a score or string that qualifies the entity.
   */
  core.List<Property> properties;
  /** Overall score of the result. Range [0, 1]. */
  core.double score;
  /**
   * The relevancy of the ICA (Image Content Annotation) label to the
   * image. For example, the relevancy of "tower" is likely higher to an image
   * containing the detected "Eiffel Tower" than to an image containing a
   * detected distant towering building, even though the confidence that
   * there is a tower in each image may be the same. Range [0, 1].
   */
  core.double topicality;

  EntityAnnotation();

  EntityAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("boundingPoly")) {
      boundingPoly = new BoundingPoly.fromJson(_json["boundingPoly"]);
    }
    if (_json.containsKey("confidence")) {
      confidence = _json["confidence"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("locations")) {
      locations = _json["locations"].map((value) => new LocationInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("mid")) {
      mid = _json["mid"];
    }
    if (_json.containsKey("properties")) {
      properties = _json["properties"].map((value) => new Property.fromJson(value)).toList();
    }
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
    if (_json.containsKey("topicality")) {
      topicality = _json["topicality"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boundingPoly != null) {
      _json["boundingPoly"] = (boundingPoly).toJson();
    }
    if (confidence != null) {
      _json["confidence"] = confidence;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (locations != null) {
      _json["locations"] = locations.map((value) => (value).toJson()).toList();
    }
    if (mid != null) {
      _json["mid"] = mid;
    }
    if (properties != null) {
      _json["properties"] = properties.map((value) => (value).toJson()).toList();
    }
    if (score != null) {
      _json["score"] = score;
    }
    if (topicality != null) {
      _json["topicality"] = topicality;
    }
    return _json;
  }
}

/** A face annotation object contains the results of face detection. */
class FaceAnnotation {
  /**
   * Anger likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String angerLikelihood;
  /**
   * Blurred likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String blurredLikelihood;
  /**
   * The bounding polygon around the face. The coordinates of the bounding box
   * are in the original image's scale, as returned in `ImageParams`.
   * The bounding box is computed to "frame" the face in accordance with human
   * expectations. It is based on the landmarker results.
   * Note that one or more x and/or y coordinates may not be generated in the
   * `BoundingPoly` (the polygon will be unbounded) if only a partial face
   * appears in the image to be annotated.
   */
  BoundingPoly boundingPoly;
  /** Detection confidence. Range [0, 1]. */
  core.double detectionConfidence;
  /**
   * The `fd_bounding_poly` bounding polygon is tighter than the
   * `boundingPoly`, and encloses only the skin part of the face. Typically, it
   * is used to eliminate the face from any image analysis that detects the
   * "amount of skin" visible in an image. It is not based on the
   * landmarker results, only on the initial face detection, hence
   * the <code>fd</code> (face detection) prefix.
   */
  BoundingPoly fdBoundingPoly;
  /**
   * Headwear likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String headwearLikelihood;
  /**
   * Joy likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String joyLikelihood;
  /** Face landmarking confidence. Range [0, 1]. */
  core.double landmarkingConfidence;
  /** Detected face landmarks. */
  core.List<Landmark> landmarks;
  /**
   * Yaw angle, which indicates the leftward/rightward angle that the face is
   * pointing relative to the vertical plane perpendicular to the image. Range
   * [-180,180].
   */
  core.double panAngle;
  /**
   * Roll angle, which indicates the amount of clockwise/anti-clockwise rotation
   * of the face relative to the image vertical about the axis perpendicular to
   * the face. Range [-180,180].
   */
  core.double rollAngle;
  /**
   * Sorrow likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String sorrowLikelihood;
  /**
   * Surprise likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String surpriseLikelihood;
  /**
   * Pitch angle, which indicates the upwards/downwards angle that the face is
   * pointing relative to the image's horizontal plane. Range [-180,180].
   */
  core.double tiltAngle;
  /**
   * Under-exposed likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String underExposedLikelihood;

  FaceAnnotation();

  FaceAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("angerLikelihood")) {
      angerLikelihood = _json["angerLikelihood"];
    }
    if (_json.containsKey("blurredLikelihood")) {
      blurredLikelihood = _json["blurredLikelihood"];
    }
    if (_json.containsKey("boundingPoly")) {
      boundingPoly = new BoundingPoly.fromJson(_json["boundingPoly"]);
    }
    if (_json.containsKey("detectionConfidence")) {
      detectionConfidence = _json["detectionConfidence"];
    }
    if (_json.containsKey("fdBoundingPoly")) {
      fdBoundingPoly = new BoundingPoly.fromJson(_json["fdBoundingPoly"]);
    }
    if (_json.containsKey("headwearLikelihood")) {
      headwearLikelihood = _json["headwearLikelihood"];
    }
    if (_json.containsKey("joyLikelihood")) {
      joyLikelihood = _json["joyLikelihood"];
    }
    if (_json.containsKey("landmarkingConfidence")) {
      landmarkingConfidence = _json["landmarkingConfidence"];
    }
    if (_json.containsKey("landmarks")) {
      landmarks = _json["landmarks"].map((value) => new Landmark.fromJson(value)).toList();
    }
    if (_json.containsKey("panAngle")) {
      panAngle = _json["panAngle"];
    }
    if (_json.containsKey("rollAngle")) {
      rollAngle = _json["rollAngle"];
    }
    if (_json.containsKey("sorrowLikelihood")) {
      sorrowLikelihood = _json["sorrowLikelihood"];
    }
    if (_json.containsKey("surpriseLikelihood")) {
      surpriseLikelihood = _json["surpriseLikelihood"];
    }
    if (_json.containsKey("tiltAngle")) {
      tiltAngle = _json["tiltAngle"];
    }
    if (_json.containsKey("underExposedLikelihood")) {
      underExposedLikelihood = _json["underExposedLikelihood"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (angerLikelihood != null) {
      _json["angerLikelihood"] = angerLikelihood;
    }
    if (blurredLikelihood != null) {
      _json["blurredLikelihood"] = blurredLikelihood;
    }
    if (boundingPoly != null) {
      _json["boundingPoly"] = (boundingPoly).toJson();
    }
    if (detectionConfidence != null) {
      _json["detectionConfidence"] = detectionConfidence;
    }
    if (fdBoundingPoly != null) {
      _json["fdBoundingPoly"] = (fdBoundingPoly).toJson();
    }
    if (headwearLikelihood != null) {
      _json["headwearLikelihood"] = headwearLikelihood;
    }
    if (joyLikelihood != null) {
      _json["joyLikelihood"] = joyLikelihood;
    }
    if (landmarkingConfidence != null) {
      _json["landmarkingConfidence"] = landmarkingConfidence;
    }
    if (landmarks != null) {
      _json["landmarks"] = landmarks.map((value) => (value).toJson()).toList();
    }
    if (panAngle != null) {
      _json["panAngle"] = panAngle;
    }
    if (rollAngle != null) {
      _json["rollAngle"] = rollAngle;
    }
    if (sorrowLikelihood != null) {
      _json["sorrowLikelihood"] = sorrowLikelihood;
    }
    if (surpriseLikelihood != null) {
      _json["surpriseLikelihood"] = surpriseLikelihood;
    }
    if (tiltAngle != null) {
      _json["tiltAngle"] = tiltAngle;
    }
    if (underExposedLikelihood != null) {
      _json["underExposedLikelihood"] = underExposedLikelihood;
    }
    return _json;
  }
}

/**
 * Users describe the type of Google Cloud Vision API tasks to perform over
 * images by using *Feature*s. Each Feature indicates a type of image
 * detection task to perform. Features encode the Cloud Vision API
 * vertical to operate on and the number of top-scoring results to return.
 */
class Feature {
  /** Maximum number of results of this type. */
  core.int maxResults;
  /**
   * The feature type.
   * Possible string values are:
   * - "TYPE_UNSPECIFIED" : Unspecified feature type.
   * - "FACE_DETECTION" : Run face detection.
   * - "LANDMARK_DETECTION" : Run landmark detection.
   * - "LOGO_DETECTION" : Run logo detection.
   * - "LABEL_DETECTION" : Run label detection.
   * - "TEXT_DETECTION" : Run OCR.
   * - "DOCUMENT_TEXT_DETECTION" : Run dense text document OCR. Takes precedence
   * when both
   * DOCUMENT_TEXT_DETECTION and TEXT_DETECTION are present.
   * - "SAFE_SEARCH_DETECTION" : Run computer vision models to compute image
   * safe-search properties.
   * - "IMAGE_PROPERTIES" : Compute a set of image properties, such as the
   * image's dominant colors.
   * - "CROP_HINTS" : Run crop hints.
   * - "WEB_DETECTION" : Run web detection.
   */
  core.String type;

  Feature();

  Feature.fromJson(core.Map _json) {
    if (_json.containsKey("maxResults")) {
      maxResults = _json["maxResults"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxResults != null) {
      _json["maxResults"] = maxResults;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Client image to perform Google Cloud Vision API tasks over. */
class Image {
  /**
   * Image content, represented as a stream of bytes.
   * Note: as with all `bytes` fields, protobuffers use a pure binary
   * representation, whereas JSON representations use base64.
   */
  core.String content;
  core.List<core.int> get contentAsBytes {
    return convert.BASE64.decode(content);
  }

  void set contentAsBytes(core.List<core.int> _bytes) {
    content = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * Google Cloud Storage image location. If both `content` and `source`
   * are provided for an image, `content` takes precedence and is
   * used to perform the image annotation request.
   */
  ImageSource source;

  Image();

  Image.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("source")) {
      source = new ImageSource.fromJson(_json["source"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (content != null) {
      _json["content"] = content;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

/** Image context and/or feature-specific parameters. */
class ImageContext {
  /** Parameters for crop hints annotation request. */
  CropHintsParams cropHintsParams;
  /**
   * List of languages to use for TEXT_DETECTION. In most cases, an empty value
   * yields the best results since it enables automatic language detection. For
   * languages based on the Latin alphabet, setting `language_hints` is not
   * needed. In rare cases, when the language of the text in the image is known,
   * setting a hint will help get better results (although it will be a
   * significant hindrance if the hint is wrong). Text detection returns an
   * error if one or more of the specified languages is not one of the
   * [supported languages](/vision/docs/languages).
   */
  core.List<core.String> languageHints;
  /** lat/long rectangle that specifies the location of the image. */
  LatLongRect latLongRect;

  ImageContext();

  ImageContext.fromJson(core.Map _json) {
    if (_json.containsKey("cropHintsParams")) {
      cropHintsParams = new CropHintsParams.fromJson(_json["cropHintsParams"]);
    }
    if (_json.containsKey("languageHints")) {
      languageHints = _json["languageHints"];
    }
    if (_json.containsKey("latLongRect")) {
      latLongRect = new LatLongRect.fromJson(_json["latLongRect"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cropHintsParams != null) {
      _json["cropHintsParams"] = (cropHintsParams).toJson();
    }
    if (languageHints != null) {
      _json["languageHints"] = languageHints;
    }
    if (latLongRect != null) {
      _json["latLongRect"] = (latLongRect).toJson();
    }
    return _json;
  }
}

/** Stores image properties, such as dominant colors. */
class ImageProperties {
  /** If present, dominant colors completed successfully. */
  DominantColorsAnnotation dominantColors;

  ImageProperties();

  ImageProperties.fromJson(core.Map _json) {
    if (_json.containsKey("dominantColors")) {
      dominantColors = new DominantColorsAnnotation.fromJson(_json["dominantColors"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dominantColors != null) {
      _json["dominantColors"] = (dominantColors).toJson();
    }
    return _json;
  }
}

/** External image source (Google Cloud Storage image location). */
class ImageSource {
  /**
   * NOTE: For new code `image_uri` below is preferred.
   * Google Cloud Storage image URI, which must be in the following form:
   * `gs://bucket_name/object_name` (for details, see
   * [Google Cloud Storage Request
   * URIs](https://cloud.google.com/storage/docs/reference-uris)).
   * NOTE: Cloud Storage object versioning is not supported.
   */
  core.String gcsImageUri;
  /**
   * Image URI which supports:
   * 1) Google Cloud Storage image URI, which must be in the following form:
   * `gs://bucket_name/object_name` (for details, see
   * [Google Cloud Storage Request
   * URIs](https://cloud.google.com/storage/docs/reference-uris)).
   * NOTE: Cloud Storage object versioning is not supported.
   * 2) Publicly accessible image HTTP/HTTPS URL.
   * This is preferred over the legacy `gcs_image_uri` above. When both
   * `gcs_image_uri` and `image_uri` are specified, `image_uri` takes
   * precedence.
   */
  core.String imageUri;

  ImageSource();

  ImageSource.fromJson(core.Map _json) {
    if (_json.containsKey("gcsImageUri")) {
      gcsImageUri = _json["gcsImageUri"];
    }
    if (_json.containsKey("imageUri")) {
      imageUri = _json["imageUri"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (gcsImageUri != null) {
      _json["gcsImageUri"] = gcsImageUri;
    }
    if (imageUri != null) {
      _json["imageUri"] = imageUri;
    }
    return _json;
  }
}

/**
 * A face-specific landmark (for example, a face feature).
 * Landmark positions may fall outside the bounds of the image
 * if the face is near one or more edges of the image.
 * Therefore it is NOT guaranteed that `0 <= x < width` or
 * `0 <= y < height`.
 */
class Landmark {
  /** Face landmark position. */
  Position position;
  /**
   * Face landmark type.
   * Possible string values are:
   * - "UNKNOWN_LANDMARK" : Unknown face landmark detected. Should not be
   * filled.
   * - "LEFT_EYE" : Left eye.
   * - "RIGHT_EYE" : Right eye.
   * - "LEFT_OF_LEFT_EYEBROW" : Left of left eyebrow.
   * - "RIGHT_OF_LEFT_EYEBROW" : Right of left eyebrow.
   * - "LEFT_OF_RIGHT_EYEBROW" : Left of right eyebrow.
   * - "RIGHT_OF_RIGHT_EYEBROW" : Right of right eyebrow.
   * - "MIDPOINT_BETWEEN_EYES" : Midpoint between eyes.
   * - "NOSE_TIP" : Nose tip.
   * - "UPPER_LIP" : Upper lip.
   * - "LOWER_LIP" : Lower lip.
   * - "MOUTH_LEFT" : Mouth left.
   * - "MOUTH_RIGHT" : Mouth right.
   * - "MOUTH_CENTER" : Mouth center.
   * - "NOSE_BOTTOM_RIGHT" : Nose, bottom right.
   * - "NOSE_BOTTOM_LEFT" : Nose, bottom left.
   * - "NOSE_BOTTOM_CENTER" : Nose, bottom center.
   * - "LEFT_EYE_TOP_BOUNDARY" : Left eye, top boundary.
   * - "LEFT_EYE_RIGHT_CORNER" : Left eye, right corner.
   * - "LEFT_EYE_BOTTOM_BOUNDARY" : Left eye, bottom boundary.
   * - "LEFT_EYE_LEFT_CORNER" : Left eye, left corner.
   * - "RIGHT_EYE_TOP_BOUNDARY" : Right eye, top boundary.
   * - "RIGHT_EYE_RIGHT_CORNER" : Right eye, right corner.
   * - "RIGHT_EYE_BOTTOM_BOUNDARY" : Right eye, bottom boundary.
   * - "RIGHT_EYE_LEFT_CORNER" : Right eye, left corner.
   * - "LEFT_EYEBROW_UPPER_MIDPOINT" : Left eyebrow, upper midpoint.
   * - "RIGHT_EYEBROW_UPPER_MIDPOINT" : Right eyebrow, upper midpoint.
   * - "LEFT_EAR_TRAGION" : Left ear tragion.
   * - "RIGHT_EAR_TRAGION" : Right ear tragion.
   * - "LEFT_EYE_PUPIL" : Left eye pupil.
   * - "RIGHT_EYE_PUPIL" : Right eye pupil.
   * - "FOREHEAD_GLABELLA" : Forehead glabella.
   * - "CHIN_GNATHION" : Chin gnathion.
   * - "CHIN_LEFT_GONION" : Chin left gonion.
   * - "CHIN_RIGHT_GONION" : Chin right gonion.
   */
  core.String type;

  Landmark();

  Landmark.fromJson(core.Map _json) {
    if (_json.containsKey("position")) {
      position = new Position.fromJson(_json["position"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * An object representing a latitude/longitude pair. This is expressed as a pair
 * of doubles representing degrees latitude and degrees longitude. Unless
 * specified otherwise, this must conform to the
 * <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
 * standard</a>. Values must be within normalized ranges.
 *
 * Example of normalization code in Python:
 *
 *     def NormalizeLongitude(longitude):
 *       """Wraps decimal degrees longitude to [-180.0, 180.0]."""
 *       q, r = divmod(longitude, 360.0)
 *       if r > 180.0 or (r == 180.0 and q <= -1.0):
 *         return r - 360.0
 *       return r
 *
 *     def NormalizeLatLng(latitude, longitude):
 *       """Wraps decimal degrees latitude and longitude to
 *       [-90.0, 90.0] and [-180.0, 180.0], respectively."""
 *       r = latitude % 360.0
 *       if r <= 90.0:
 *         return r, NormalizeLongitude(longitude)
 *       elif r >= 270.0:
 *         return r - 360, NormalizeLongitude(longitude)
 *       else:
 *         return 180 - r, NormalizeLongitude(longitude + 180.0)
 *
 *     assert 180.0 == NormalizeLongitude(180.0)
 *     assert -180.0 == NormalizeLongitude(-180.0)
 *     assert -179.0 == NormalizeLongitude(181.0)
 *     assert (0.0, 0.0) == NormalizeLatLng(360.0, 0.0)
 *     assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
 *     assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0)
 *     assert (-85.0, -170.0) == NormalizeLatLng(-95.0, 10.0)
 *     assert (90.0, 10.0) == NormalizeLatLng(90.0, 10.0)
 *     assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0)
 *     assert (0.0, -170.0) == NormalizeLatLng(-180.0, 10.0)
 *     assert (0.0, -170.0) == NormalizeLatLng(180.0, 10.0)
 *     assert (-90.0, 10.0) == NormalizeLatLng(270.0, 10.0)
 *     assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
 *
 * The code in logs/storage/validator/logs_validator_traits.cc treats this type
 * as if it were annotated as ST_LOCATION.
 */
class LatLng {
  /** The latitude in degrees. It must be in the range [-90.0, +90.0]. */
  core.double latitude;
  /** The longitude in degrees. It must be in the range [-180.0, +180.0]. */
  core.double longitude;

  LatLng();

  LatLng.fromJson(core.Map _json) {
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

/** Rectangle determined by min and max `LatLng` pairs. */
class LatLongRect {
  /** Max lat/long pair. */
  LatLng maxLatLng;
  /** Min lat/long pair. */
  LatLng minLatLng;

  LatLongRect();

  LatLongRect.fromJson(core.Map _json) {
    if (_json.containsKey("maxLatLng")) {
      maxLatLng = new LatLng.fromJson(_json["maxLatLng"]);
    }
    if (_json.containsKey("minLatLng")) {
      minLatLng = new LatLng.fromJson(_json["minLatLng"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxLatLng != null) {
      _json["maxLatLng"] = (maxLatLng).toJson();
    }
    if (minLatLng != null) {
      _json["minLatLng"] = (minLatLng).toJson();
    }
    return _json;
  }
}

/** Detected entity location information. */
class LocationInfo {
  /** lat/long location coordinates. */
  LatLng latLng;

  LocationInfo();

  LocationInfo.fromJson(core.Map _json) {
    if (_json.containsKey("latLng")) {
      latLng = new LatLng.fromJson(_json["latLng"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (latLng != null) {
      _json["latLng"] = (latLng).toJson();
    }
    return _json;
  }
}

/** Detected page from OCR. */
class Page {
  /** List of blocks of text, images etc on this page. */
  core.List<Block> blocks;
  /** Page height in pixels. */
  core.int height;
  /** Additional information detected on the page. */
  TextProperty property;
  /** Page width in pixels. */
  core.int width;

  Page();

  Page.fromJson(core.Map _json) {
    if (_json.containsKey("blocks")) {
      blocks = _json["blocks"].map((value) => new Block.fromJson(value)).toList();
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("property")) {
      property = new TextProperty.fromJson(_json["property"]);
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blocks != null) {
      _json["blocks"] = blocks.map((value) => (value).toJson()).toList();
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** Structural unit of text representing a number of words in certain order. */
class Paragraph {
  /**
   * The bounding box for the paragraph.
   * The vertices are in the order of top-left, top-right, bottom-right,
   * bottom-left. When a rotation of the bounding box is detected the rotation
   * is represented as around the top-left corner as defined when the text is
   * read in the 'natural' orientation.
   * For example:
   *   * when the text is horizontal it might look like:
   *      0----1
   *      |    |
   *      3----2
   *   * when it's rotated 180 degrees around the top-left corner it becomes:
   *      2----3
   *      |    |
   *      1----0
   *   and the vertice order will still be (0, 1, 2, 3).
   */
  BoundingPoly boundingBox;
  /** Additional information detected for the paragraph. */
  TextProperty property;
  /** List of words in this paragraph. */
  core.List<Word> words;

  Paragraph();

  Paragraph.fromJson(core.Map _json) {
    if (_json.containsKey("boundingBox")) {
      boundingBox = new BoundingPoly.fromJson(_json["boundingBox"]);
    }
    if (_json.containsKey("property")) {
      property = new TextProperty.fromJson(_json["property"]);
    }
    if (_json.containsKey("words")) {
      words = _json["words"].map((value) => new Word.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boundingBox != null) {
      _json["boundingBox"] = (boundingBox).toJson();
    }
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    if (words != null) {
      _json["words"] = words.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A 3D position in the image, used primarily for Face detection landmarks.
 * A valid Position must have both x and y coordinates.
 * The position coordinates are in the same scale as the original image.
 */
class Position {
  /** X coordinate. */
  core.double x;
  /** Y coordinate. */
  core.double y;
  /** Z coordinate (or depth). */
  core.double z;

  Position();

  Position.fromJson(core.Map _json) {
    if (_json.containsKey("x")) {
      x = _json["x"];
    }
    if (_json.containsKey("y")) {
      y = _json["y"];
    }
    if (_json.containsKey("z")) {
      z = _json["z"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (x != null) {
      _json["x"] = x;
    }
    if (y != null) {
      _json["y"] = y;
    }
    if (z != null) {
      _json["z"] = z;
    }
    return _json;
  }
}

/** A `Property` consists of a user-supplied name/value pair. */
class Property {
  /** Name of the property. */
  core.String name;
  /** Value of numeric properties. */
  core.String uint64Value;
  /** Value of the property. */
  core.String value;

  Property();

  Property.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("uint64Value")) {
      uint64Value = _json["uint64Value"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (uint64Value != null) {
      _json["uint64Value"] = uint64Value;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * Set of features pertaining to the image, computed by computer vision
 * methods over safe-search verticals (for example, adult, spoof, medical,
 * violence).
 */
class SafeSearchAnnotation {
  /**
   * Represents the adult content likelihood for the image.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String adult;
  /**
   * Likelihood that this is a medical image.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String medical;
  /**
   * Spoof likelihood. The likelihood that an modification
   * was made to the image's canonical version to make it appear
   * funny or offensive.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String spoof;
  /**
   * Violence likelihood.
   * Possible string values are:
   * - "UNKNOWN" : Unknown likelihood.
   * - "VERY_UNLIKELY" : It is very unlikely that the image belongs to the
   * specified vertical.
   * - "UNLIKELY" : It is unlikely that the image belongs to the specified
   * vertical.
   * - "POSSIBLE" : It is possible that the image belongs to the specified
   * vertical.
   * - "LIKELY" : It is likely that the image belongs to the specified vertical.
   * - "VERY_LIKELY" : It is very likely that the image belongs to the specified
   * vertical.
   */
  core.String violence;

  SafeSearchAnnotation();

  SafeSearchAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("adult")) {
      adult = _json["adult"];
    }
    if (_json.containsKey("medical")) {
      medical = _json["medical"];
    }
    if (_json.containsKey("spoof")) {
      spoof = _json["spoof"];
    }
    if (_json.containsKey("violence")) {
      violence = _json["violence"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adult != null) {
      _json["adult"] = adult;
    }
    if (medical != null) {
      _json["medical"] = medical;
    }
    if (spoof != null) {
      _json["spoof"] = spoof;
    }
    if (violence != null) {
      _json["violence"] = violence;
    }
    return _json;
  }
}

/**
 * The `Status` type defines a logical error model that is suitable for
 * different
 * programming environments, including REST APIs and RPC APIs. It is used by
 * [gRPC](https://github.com/grpc). The error model is designed to be:
 *
 * - Simple to use and understand for most users
 * - Flexible enough to meet unexpected needs
 *
 * # Overview
 *
 * The `Status` message contains three pieces of data: error code, error
 * message,
 * and error details. The error code should be an enum value of
 * google.rpc.Code, but it may accept additional error codes if needed.  The
 * error message should be a developer-facing English message that helps
 * developers *understand* and *resolve* the error. If a localized user-facing
 * error message is needed, put the localized message in the error details or
 * localize it in the client. The optional error details may contain arbitrary
 * information about the error. There is a predefined set of error detail types
 * in the package `google.rpc` which can be used for common error conditions.
 *
 * # Language mapping
 *
 * The `Status` message is the logical representation of the error model, but it
 * is not necessarily the actual wire format. When the `Status` message is
 * exposed in different client libraries and different wire protocols, it can be
 * mapped differently. For example, it will likely be mapped to some exceptions
 * in Java, but more likely mapped to some error codes in C.
 *
 * # Other uses
 *
 * The error model and the `Status` message can be used in a variety of
 * environments, either with or without APIs, to provide a
 * consistent developer experience across different environments.
 *
 * Example uses of this error model include:
 *
 * - Partial errors. If a service needs to return partial errors to the client,
 *     it may embed the `Status` in the normal response to indicate the partial
 *     errors.
 *
 * - Workflow errors. A typical workflow has multiple steps. Each step may
 *     have a `Status` message for error reporting purpose.
 *
 * - Batch operations. If a client uses batch request and batch response, the
 *     `Status` message should be used directly inside batch response, one for
 *     each error sub-response.
 *
 * - Asynchronous operations. If an API call embeds asynchronous operation
 *     results in its response, the status of those operations should be
 *     represented directly using the `Status` message.
 *
 * - Logging. If some API errors are stored in logs, the message `Status` could
 * be used directly after any stripping needed for security/privacy reasons.
 */
class Status {
  /** The status code, which should be an enum value of google.rpc.Code. */
  core.int code;
  /**
   * A list of messages that carry the error details.  There will be a
   * common set of message types for APIs to use.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Map<core.String, core.Object>> details;
  /**
   * A developer-facing error message, which should be in English. Any
   * user-facing error message should be localized and sent in the
   * google.rpc.Status.details field, or localized by the client.
   */
  core.String message;

  Status();

  Status.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("details")) {
      details = _json["details"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (details != null) {
      _json["details"] = details;
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/** A single symbol representation. */
class Symbol {
  /**
   * The bounding box for the symbol.
   * The vertices are in the order of top-left, top-right, bottom-right,
   * bottom-left. When a rotation of the bounding box is detected the rotation
   * is represented as around the top-left corner as defined when the text is
   * read in the 'natural' orientation.
   * For example:
   *   * when the text is horizontal it might look like:
   *      0----1
   *      |    |
   *      3----2
   *   * when it's rotated 180 degrees around the top-left corner it becomes:
   *      2----3
   *      |    |
   *      1----0
   *   and the vertice order will still be (0, 1, 2, 3).
   */
  BoundingPoly boundingBox;
  /** Additional information detected for the symbol. */
  TextProperty property;
  /** The actual UTF-8 representation of the symbol. */
  core.String text;

  Symbol();

  Symbol.fromJson(core.Map _json) {
    if (_json.containsKey("boundingBox")) {
      boundingBox = new BoundingPoly.fromJson(_json["boundingBox"]);
    }
    if (_json.containsKey("property")) {
      property = new TextProperty.fromJson(_json["property"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boundingBox != null) {
      _json["boundingBox"] = (boundingBox).toJson();
    }
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

/**
 * TextAnnotation contains a structured representation of OCR extracted text.
 * The hierarchy of an OCR extracted text structure is like this:
 *     TextAnnotation -> Page -> Block -> Paragraph -> Word -> Symbol
 * Each structural component, starting from Page, may further have their own
 * properties. Properties describe detected languages, breaks etc.. Please
 * refer to the google.cloud.vision.v1.TextAnnotation.TextProperty message
 * definition below for more detail.
 */
class TextAnnotation {
  /** List of pages detected by OCR. */
  core.List<Page> pages;
  /** UTF-8 text detected on the pages. */
  core.String text;

  TextAnnotation();

  TextAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("pages")) {
      pages = _json["pages"].map((value) => new Page.fromJson(value)).toList();
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pages != null) {
      _json["pages"] = pages.map((value) => (value).toJson()).toList();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

/** Additional information detected on the structural component. */
class TextProperty {
  /** Detected start or end of a text segment. */
  DetectedBreak detectedBreak;
  /** A list of detected languages together with confidence. */
  core.List<DetectedLanguage> detectedLanguages;

  TextProperty();

  TextProperty.fromJson(core.Map _json) {
    if (_json.containsKey("detectedBreak")) {
      detectedBreak = new DetectedBreak.fromJson(_json["detectedBreak"]);
    }
    if (_json.containsKey("detectedLanguages")) {
      detectedLanguages = _json["detectedLanguages"].map((value) => new DetectedLanguage.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (detectedBreak != null) {
      _json["detectedBreak"] = (detectedBreak).toJson();
    }
    if (detectedLanguages != null) {
      _json["detectedLanguages"] = detectedLanguages.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A vertex represents a 2D point in the image.
 * NOTE: the vertex coordinates are in the same scale as the original image.
 */
class Vertex {
  /** X coordinate. */
  core.int x;
  /** Y coordinate. */
  core.int y;

  Vertex();

  Vertex.fromJson(core.Map _json) {
    if (_json.containsKey("x")) {
      x = _json["x"];
    }
    if (_json.containsKey("y")) {
      y = _json["y"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (x != null) {
      _json["x"] = x;
    }
    if (y != null) {
      _json["y"] = y;
    }
    return _json;
  }
}

/** Relevant information for the image from the Internet. */
class WebDetection {
  /**
   * Fully matching images from the Internet.
   * They're definite neardups and most often a copy of the query image with
   * merely a size change.
   */
  core.List<WebImage> fullMatchingImages;
  /** Web pages containing the matching images from the Internet. */
  core.List<WebPage> pagesWithMatchingImages;
  /**
   * Partial matching images from the Internet.
   * Those images are similar enough to share some key-point features. For
   * example an original image will likely have partial matching for its crops.
   */
  core.List<WebImage> partialMatchingImages;
  /** Deduced entities from similar images on the Internet. */
  core.List<WebEntity> webEntities;

  WebDetection();

  WebDetection.fromJson(core.Map _json) {
    if (_json.containsKey("fullMatchingImages")) {
      fullMatchingImages = _json["fullMatchingImages"].map((value) => new WebImage.fromJson(value)).toList();
    }
    if (_json.containsKey("pagesWithMatchingImages")) {
      pagesWithMatchingImages = _json["pagesWithMatchingImages"].map((value) => new WebPage.fromJson(value)).toList();
    }
    if (_json.containsKey("partialMatchingImages")) {
      partialMatchingImages = _json["partialMatchingImages"].map((value) => new WebImage.fromJson(value)).toList();
    }
    if (_json.containsKey("webEntities")) {
      webEntities = _json["webEntities"].map((value) => new WebEntity.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fullMatchingImages != null) {
      _json["fullMatchingImages"] = fullMatchingImages.map((value) => (value).toJson()).toList();
    }
    if (pagesWithMatchingImages != null) {
      _json["pagesWithMatchingImages"] = pagesWithMatchingImages.map((value) => (value).toJson()).toList();
    }
    if (partialMatchingImages != null) {
      _json["partialMatchingImages"] = partialMatchingImages.map((value) => (value).toJson()).toList();
    }
    if (webEntities != null) {
      _json["webEntities"] = webEntities.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Entity deduced from similar images on the Internet. */
class WebEntity {
  /** Canonical description of the entity, in English. */
  core.String description;
  /** Opaque entity ID. */
  core.String entityId;
  /**
   * Overall relevancy score for the entity.
   * Not normalized and not comparable across different image queries.
   */
  core.double score;

  WebEntity();

  WebEntity.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
    }
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
    }
    if (score != null) {
      _json["score"] = score;
    }
    return _json;
  }
}

/** Metadata for online images. */
class WebImage {
  /**
   * Overall relevancy score for the image.
   * Not normalized and not comparable across different image queries.
   */
  core.double score;
  /** The result image URL. */
  core.String url;

  WebImage();

  WebImage.fromJson(core.Map _json) {
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (score != null) {
      _json["score"] = score;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Metadata for web pages. */
class WebPage {
  /**
   * Overall relevancy score for the web page.
   * Not normalized and not comparable across different image queries.
   */
  core.double score;
  /** The result web page URL. */
  core.String url;

  WebPage();

  WebPage.fromJson(core.Map _json) {
    if (_json.containsKey("score")) {
      score = _json["score"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (score != null) {
      _json["score"] = score;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** A word representation. */
class Word {
  /**
   * The bounding box for the word.
   * The vertices are in the order of top-left, top-right, bottom-right,
   * bottom-left. When a rotation of the bounding box is detected the rotation
   * is represented as around the top-left corner as defined when the text is
   * read in the 'natural' orientation.
   * For example:
   *   * when the text is horizontal it might look like:
   *      0----1
   *      |    |
   *      3----2
   *   * when it's rotated 180 degrees around the top-left corner it becomes:
   *      2----3
   *      |    |
   *      1----0
   *   and the vertice order will still be (0, 1, 2, 3).
   */
  BoundingPoly boundingBox;
  /** Additional information detected for the word. */
  TextProperty property;
  /**
   * List of symbols in the word.
   * The order of the symbols follows the natural reading order.
   */
  core.List<Symbol> symbols;

  Word();

  Word.fromJson(core.Map _json) {
    if (_json.containsKey("boundingBox")) {
      boundingBox = new BoundingPoly.fromJson(_json["boundingBox"]);
    }
    if (_json.containsKey("property")) {
      property = new TextProperty.fromJson(_json["property"]);
    }
    if (_json.containsKey("symbols")) {
      symbols = _json["symbols"].map((value) => new Symbol.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boundingBox != null) {
      _json["boundingBox"] = (boundingBox).toJson();
    }
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    if (symbols != null) {
      _json["symbols"] = symbols.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
