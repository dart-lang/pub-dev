// This is a generated file (see the discoveryapis_generator project).

library googleapis.qpxExpress.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client qpxExpress/v1';

/** Finds the least expensive flights between an origin and a destination. */
class QpxExpressApi {

  final commons.ApiRequester _requester;

  TripsResourceApi get trips => new TripsResourceApi(_requester);

  QpxExpressApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "qpxExpress/v1/trips/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class TripsResourceApi {
  final commons.ApiRequester _requester;

  TripsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of flights.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [TripsSearchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TripsSearchResponse> search(TripsSearchRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TripsSearchResponse.fromJson(data));
  }

}



/** The make, model, and type of an aircraft. */
class AircraftData {
  /**
   * The aircraft code. For example, for a Boeing 777 the code would be 777.
   */
  core.String code;
  /**
   * Identifies this as an aircraftData object. Value: the fixed string
   * qpxexpress#aircraftData
   */
  core.String kind;
  /** The name of an aircraft, for example Boeing 777. */
  core.String name;

  AircraftData();

  AircraftData.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** An airport. */
class AirportData {
  /**
   * The city code an airport is located in. For example, for JFK airport, this
   * is NYC.
   */
  core.String city;
  /** An airport's code. For example, for Boston Logan airport, this is BOS. */
  core.String code;
  /**
   * Identifies this as an airport object. Value: the fixed string
   * qpxexpress#airportData.
   */
  core.String kind;
  /**
   * The name of an airport. For example, for airport BOS the name is "Boston
   * Logan International".
   */
  core.String name;

  AirportData();

  AirportData.fromJson(core.Map _json) {
    if (_json.containsKey("city")) {
      city = _json["city"];
    }
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (city != null) {
      _json["city"] = city;
    }
    if (code != null) {
      _json["code"] = code;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Information about an item of baggage. */
class BagDescriptor {
  /** Provides the commercial name for an optional service. */
  core.String commercialName;
  /** How many of this type of bag will be checked on this flight. */
  core.int count;
  /** A description of the baggage. */
  core.List<core.String> description;
  /**
   * Identifies this as a baggage object. Value: the fixed string
   * qpxexpress#bagDescriptor.
   */
  core.String kind;
  /** The standard IATA subcode used to identify this optional service. */
  core.String subcode;

  BagDescriptor();

  BagDescriptor.fromJson(core.Map _json) {
    if (_json.containsKey("commercialName")) {
      commercialName = _json["commercialName"];
    }
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("subcode")) {
      subcode = _json["subcode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (commercialName != null) {
      _json["commercialName"] = commercialName;
    }
    if (count != null) {
      _json["count"] = count;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (subcode != null) {
      _json["subcode"] = subcode;
    }
    return _json;
  }
}

/**
 * Information about a carrier (ie. an airline, bus line, railroad, etc) that
 * might be useful to display to an end-user.
 */
class CarrierData {
  /**
   * The IATA designator of a carrier (airline, etc). For example, for American
   * Airlines, the code is AA.
   */
  core.String code;
  /**
   * Identifies this as a kind of carrier (ie. an airline, bus line, railroad,
   * etc). Value: the fixed string qpxexpress#carrierData.
   */
  core.String kind;
  /** The long, full name of a carrier. For example: American Airlines. */
  core.String name;

  CarrierData();

  CarrierData.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Information about a city that might be useful to an end-user; typically the
 * city of an airport.
 */
class CityData {
  /** The IATA character ID of a city. For example, for Boston this is BOS. */
  core.String code;
  /**
   * The two-character country code of the country the city is located in. For
   * example, US for the United States of America.
   */
  core.String country;
  /**
   * Identifies this as a city, typically with one or more airports. Value: the
   * fixed string qpxexpress#cityData.
   */
  core.String kind;
  /** The full name of a city. An example would be: New York. */
  core.String name;

  CityData();

  CityData.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Detailed information about components found in the solutions of this
 * response, including a trip's airport, city, taxes, airline, and aircraft.
 */
class Data {
  /** The aircraft that is flying between an origin and destination. */
  core.List<AircraftData> aircraft;
  /** The airport of an origin or destination. */
  core.List<AirportData> airport;
  /**
   * The airline carrier of the aircraft flying between an origin and
   * destination. Allowed values are IATA carrier codes.
   */
  core.List<CarrierData> carrier;
  /** The city that is either the origin or destination of part of a trip. */
  core.List<CityData> city;
  /**
   * Identifies this as QPX Express response resource, including a trip's
   * airport, city, taxes, airline, and aircraft. Value: the fixed string
   * qpxexpress#data.
   */
  core.String kind;
  /** The taxes due for flying between an origin and a destination. */
  core.List<TaxData> tax;

  Data();

  Data.fromJson(core.Map _json) {
    if (_json.containsKey("aircraft")) {
      aircraft = _json["aircraft"].map((value) => new AircraftData.fromJson(value)).toList();
    }
    if (_json.containsKey("airport")) {
      airport = _json["airport"].map((value) => new AirportData.fromJson(value)).toList();
    }
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"].map((value) => new CarrierData.fromJson(value)).toList();
    }
    if (_json.containsKey("city")) {
      city = _json["city"].map((value) => new CityData.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("tax")) {
      tax = _json["tax"].map((value) => new TaxData.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aircraft != null) {
      _json["aircraft"] = aircraft.map((value) => (value).toJson()).toList();
    }
    if (airport != null) {
      _json["airport"] = airport.map((value) => (value).toJson()).toList();
    }
    if (carrier != null) {
      _json["carrier"] = carrier.map((value) => (value).toJson()).toList();
    }
    if (city != null) {
      _json["city"] = city.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (tax != null) {
      _json["tax"] = tax.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Complete information about a fare used in the solution to a low-fare search
 * query. In the airline industry a fare is a price an airline charges for
 * one-way travel between two points. A fare typically contains a carrier code,
 * two city codes, a price, and a fare basis. (A fare basis is a one-to-eight
 * character alphanumeric code used to identify a fare.)
 */
class FareInfo {
  core.String basisCode;
  /**
   * The carrier of the aircraft or other vehicle commuting between two points.
   */
  core.String carrier;
  /** The city code of the city the trip ends at. */
  core.String destination;
  /** A unique identifier of the fare. */
  core.String id;
  /**
   * Identifies this as a fare object. Value: the fixed string
   * qpxexpress#fareInfo.
   */
  core.String kind;
  /** The city code of the city the trip begins at. */
  core.String origin;
  /**
   * Whether this is a private fare, for example one offered only to select
   * customers rather than the general public.
   */
  core.bool private;

  FareInfo();

  FareInfo.fromJson(core.Map _json) {
    if (_json.containsKey("basisCode")) {
      basisCode = _json["basisCode"];
    }
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("origin")) {
      origin = _json["origin"];
    }
    if (_json.containsKey("private")) {
      private = _json["private"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (basisCode != null) {
      _json["basisCode"] = basisCode;
    }
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (origin != null) {
      _json["origin"] = origin;
    }
    if (private != null) {
      _json["private"] = private;
    }
    return _json;
  }
}

/**
 * A flight is a sequence of legs with the same airline carrier and flight
 * number. (A leg is the smallest unit of travel, in the case of a flight a
 * takeoff immediately followed by a landing at two set points on a particular
 * carrier with a particular flight number.) The naive view is that a flight is
 * scheduled travel of an aircraft between two points, with possibly
 * intermediate stops, but carriers will frequently list flights that require a
 * change of aircraft between legs.
 */
class FlightInfo {
  core.String carrier;
  /** The flight number. */
  core.String number;

  FlightInfo();

  FlightInfo.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("number")) {
      number = _json["number"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (number != null) {
      _json["number"] = number;
    }
    return _json;
  }
}

/** Information about free baggage allowed on one segment of a trip. */
class FreeBaggageAllowance {
  /**
   * A representation of a type of bag, such as an ATPCo subcode, Commercial
   * Name, or other description.
   */
  core.List<BagDescriptor> bagDescriptor;
  /** The maximum number of kilos all the free baggage together may weigh. */
  core.int kilos;
  /** The maximum number of kilos any one piece of baggage may weigh. */
  core.int kilosPerPiece;
  /**
   * Identifies this as free baggage object, allowed on one segment of a trip.
   * Value: the fixed string qpxexpress#freeBaggageAllowance.
   */
  core.String kind;
  /** The number of free pieces of baggage allowed. */
  core.int pieces;
  /** The number of pounds of free baggage allowed. */
  core.int pounds;

  FreeBaggageAllowance();

  FreeBaggageAllowance.fromJson(core.Map _json) {
    if (_json.containsKey("bagDescriptor")) {
      bagDescriptor = _json["bagDescriptor"].map((value) => new BagDescriptor.fromJson(value)).toList();
    }
    if (_json.containsKey("kilos")) {
      kilos = _json["kilos"];
    }
    if (_json.containsKey("kilosPerPiece")) {
      kilosPerPiece = _json["kilosPerPiece"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("pieces")) {
      pieces = _json["pieces"];
    }
    if (_json.containsKey("pounds")) {
      pounds = _json["pounds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bagDescriptor != null) {
      _json["bagDescriptor"] = bagDescriptor.map((value) => (value).toJson()).toList();
    }
    if (kilos != null) {
      _json["kilos"] = kilos;
    }
    if (kilosPerPiece != null) {
      _json["kilosPerPiece"] = kilosPerPiece;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (pieces != null) {
      _json["pieces"] = pieces;
    }
    if (pounds != null) {
      _json["pounds"] = pounds;
    }
    return _json;
  }
}

/**
 * Information about a leg. (A leg is the smallest unit of travel, in the case
 * of a flight a takeoff immediately followed by a landing at two set points on
 * a particular carrier with a particular flight number.)
 */
class LegInfo {
  /**
   * The aircraft (or bus, ferry, railcar, etc) travelling between the two
   * points of this leg.
   */
  core.String aircraft;
  /**
   * The scheduled time of arrival at the destination of the leg, local to the
   * point of arrival.
   */
  core.String arrivalTime;
  /**
   * Whether you have to change planes following this leg. Only applies to the
   * next leg.
   */
  core.bool changePlane;
  /** Duration of a connection following this leg, in minutes. */
  core.int connectionDuration;
  /**
   * The scheduled departure time of the leg, local to the point of departure.
   */
  core.String departureTime;
  /** The leg destination as a city and airport. */
  core.String destination;
  /** The terminal the flight is scheduled to arrive at. */
  core.String destinationTerminal;
  /** The scheduled travelling time from the origin to the destination. */
  core.int duration;
  /** An identifier that uniquely identifies this leg in the solution. */
  core.String id;
  /**
   * Identifies this as a leg object. A leg is the smallest unit of travel, in
   * the case of a flight a takeoff immediately followed by a landing at two set
   * points on a particular carrier with a particular flight number. Value: the
   * fixed string qpxexpress#legInfo.
   */
  core.String kind;
  /**
   * A simple, general description of the meal(s) served on the flight, for
   * example: "Hot meal".
   */
  core.String meal;
  /** The number of miles in this leg. */
  core.int mileage;
  /** In percent, the published on time performance on this leg. */
  core.int onTimePerformance;
  /**
   * Department of Transportation disclosure information on the actual operator
   * of a flight in a code share. (A code share refers to a marketing agreement
   * between two carriers, where one carrier will list in its schedules (and
   * take bookings for) flights that are actually operated by another carrier.)
   */
  core.String operatingDisclosure;
  /** The leg origin as a city and airport. */
  core.String origin;
  /** The terminal the flight is scheduled to depart from. */
  core.String originTerminal;
  /**
   * Whether passenger information must be furnished to the United States
   * Transportation Security Administration (TSA) prior to departure.
   */
  core.bool secure;

  LegInfo();

  LegInfo.fromJson(core.Map _json) {
    if (_json.containsKey("aircraft")) {
      aircraft = _json["aircraft"];
    }
    if (_json.containsKey("arrivalTime")) {
      arrivalTime = _json["arrivalTime"];
    }
    if (_json.containsKey("changePlane")) {
      changePlane = _json["changePlane"];
    }
    if (_json.containsKey("connectionDuration")) {
      connectionDuration = _json["connectionDuration"];
    }
    if (_json.containsKey("departureTime")) {
      departureTime = _json["departureTime"];
    }
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("destinationTerminal")) {
      destinationTerminal = _json["destinationTerminal"];
    }
    if (_json.containsKey("duration")) {
      duration = _json["duration"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("meal")) {
      meal = _json["meal"];
    }
    if (_json.containsKey("mileage")) {
      mileage = _json["mileage"];
    }
    if (_json.containsKey("onTimePerformance")) {
      onTimePerformance = _json["onTimePerformance"];
    }
    if (_json.containsKey("operatingDisclosure")) {
      operatingDisclosure = _json["operatingDisclosure"];
    }
    if (_json.containsKey("origin")) {
      origin = _json["origin"];
    }
    if (_json.containsKey("originTerminal")) {
      originTerminal = _json["originTerminal"];
    }
    if (_json.containsKey("secure")) {
      secure = _json["secure"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aircraft != null) {
      _json["aircraft"] = aircraft;
    }
    if (arrivalTime != null) {
      _json["arrivalTime"] = arrivalTime;
    }
    if (changePlane != null) {
      _json["changePlane"] = changePlane;
    }
    if (connectionDuration != null) {
      _json["connectionDuration"] = connectionDuration;
    }
    if (departureTime != null) {
      _json["departureTime"] = departureTime;
    }
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (destinationTerminal != null) {
      _json["destinationTerminal"] = destinationTerminal;
    }
    if (duration != null) {
      _json["duration"] = duration;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (meal != null) {
      _json["meal"] = meal;
    }
    if (mileage != null) {
      _json["mileage"] = mileage;
    }
    if (onTimePerformance != null) {
      _json["onTimePerformance"] = onTimePerformance;
    }
    if (operatingDisclosure != null) {
      _json["operatingDisclosure"] = operatingDisclosure;
    }
    if (origin != null) {
      _json["origin"] = origin;
    }
    if (originTerminal != null) {
      _json["originTerminal"] = originTerminal;
    }
    if (secure != null) {
      _json["secure"] = secure;
    }
    return _json;
  }
}

/**
 * The number and type of passengers. Unfortunately the definition of an infant,
 * child, adult, and senior citizen varies across carriers and reservation
 * systems.
 */
class PassengerCounts {
  /** The number of passengers that are adults. */
  core.int adultCount;
  /** The number of passengers that are children. */
  core.int childCount;
  /**
   * The number of passengers that are infants travelling in the lap of an
   * adult.
   */
  core.int infantInLapCount;
  /** The number of passengers that are infants each assigned a seat. */
  core.int infantInSeatCount;
  /**
   * Identifies this as a passenger count object, representing the number of
   * passengers. Value: the fixed string qpxexpress#passengerCounts.
   */
  core.String kind;
  /** The number of passengers that are senior citizens. */
  core.int seniorCount;

  PassengerCounts();

  PassengerCounts.fromJson(core.Map _json) {
    if (_json.containsKey("adultCount")) {
      adultCount = _json["adultCount"];
    }
    if (_json.containsKey("childCount")) {
      childCount = _json["childCount"];
    }
    if (_json.containsKey("infantInLapCount")) {
      infantInLapCount = _json["infantInLapCount"];
    }
    if (_json.containsKey("infantInSeatCount")) {
      infantInSeatCount = _json["infantInSeatCount"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("seniorCount")) {
      seniorCount = _json["seniorCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adultCount != null) {
      _json["adultCount"] = adultCount;
    }
    if (childCount != null) {
      _json["childCount"] = childCount;
    }
    if (infantInLapCount != null) {
      _json["infantInLapCount"] = infantInLapCount;
    }
    if (infantInSeatCount != null) {
      _json["infantInSeatCount"] = infantInSeatCount;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (seniorCount != null) {
      _json["seniorCount"] = seniorCount;
    }
    return _json;
  }
}

/**
 * The price of one or more travel segments. The currency used to purchase
 * tickets is usually determined by the sale/ticketing city or the
 * sale/ticketing country, unless none are specified, in which case it defaults
 * to that of the journey origin country.
 */
class PricingInfo {
  /**
   * The total fare in the base fare currency (the currency of the country of
   * origin). This element is only present when the sales currency and the
   * currency of the country of commencement are different.
   */
  core.String baseFareTotal;
  /** The fare used to price one or more segments. */
  core.List<FareInfo> fare;
  /**
   * The horizontal fare calculation. This is a field on a ticket that displays
   * all of the relevant items that go into the calculation of the fare.
   */
  core.String fareCalculation;
  /**
   * Identifies this as a pricing object, representing the price of one or more
   * travel segments. Value: the fixed string qpxexpress#pricingInfo.
   */
  core.String kind;
  /**
   * The latest ticketing time for this pricing assuming the reservation occurs
   * at ticketing time and there is no change in fares/rules. The time is local
   * to the point of sale (POS).
   */
  core.String latestTicketingTime;
  /** The number of passengers to which this price applies. */
  PassengerCounts passengers;
  /**
   * The passenger type code for this pricing. An alphanumeric code used by a
   * carrier to restrict fares to certain categories of passenger. For instance,
   * a fare might be valid only for senior citizens.
   */
  core.String ptc;
  /** Whether the fares on this pricing are refundable. */
  core.bool refundable;
  /** The total fare in the sale or equivalent currency. */
  core.String saleFareTotal;
  /** The taxes in the sale or equivalent currency. */
  core.String saleTaxTotal;
  /**
   * Total per-passenger price (fare and tax) in the sale or equivalent
   * currency.
   */
  core.String saleTotal;
  /** The per-segment price and baggage information. */
  core.List<SegmentPricing> segmentPricing;
  /** The taxes used to calculate the tax total per ticket. */
  core.List<TaxInfo> tax;

  PricingInfo();

  PricingInfo.fromJson(core.Map _json) {
    if (_json.containsKey("baseFareTotal")) {
      baseFareTotal = _json["baseFareTotal"];
    }
    if (_json.containsKey("fare")) {
      fare = _json["fare"].map((value) => new FareInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("fareCalculation")) {
      fareCalculation = _json["fareCalculation"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("latestTicketingTime")) {
      latestTicketingTime = _json["latestTicketingTime"];
    }
    if (_json.containsKey("passengers")) {
      passengers = new PassengerCounts.fromJson(_json["passengers"]);
    }
    if (_json.containsKey("ptc")) {
      ptc = _json["ptc"];
    }
    if (_json.containsKey("refundable")) {
      refundable = _json["refundable"];
    }
    if (_json.containsKey("saleFareTotal")) {
      saleFareTotal = _json["saleFareTotal"];
    }
    if (_json.containsKey("saleTaxTotal")) {
      saleTaxTotal = _json["saleTaxTotal"];
    }
    if (_json.containsKey("saleTotal")) {
      saleTotal = _json["saleTotal"];
    }
    if (_json.containsKey("segmentPricing")) {
      segmentPricing = _json["segmentPricing"].map((value) => new SegmentPricing.fromJson(value)).toList();
    }
    if (_json.containsKey("tax")) {
      tax = _json["tax"].map((value) => new TaxInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (baseFareTotal != null) {
      _json["baseFareTotal"] = baseFareTotal;
    }
    if (fare != null) {
      _json["fare"] = fare.map((value) => (value).toJson()).toList();
    }
    if (fareCalculation != null) {
      _json["fareCalculation"] = fareCalculation;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (latestTicketingTime != null) {
      _json["latestTicketingTime"] = latestTicketingTime;
    }
    if (passengers != null) {
      _json["passengers"] = (passengers).toJson();
    }
    if (ptc != null) {
      _json["ptc"] = ptc;
    }
    if (refundable != null) {
      _json["refundable"] = refundable;
    }
    if (saleFareTotal != null) {
      _json["saleFareTotal"] = saleFareTotal;
    }
    if (saleTaxTotal != null) {
      _json["saleTaxTotal"] = saleTaxTotal;
    }
    if (saleTotal != null) {
      _json["saleTotal"] = saleTotal;
    }
    if (segmentPricing != null) {
      _json["segmentPricing"] = segmentPricing.map((value) => (value).toJson()).toList();
    }
    if (tax != null) {
      _json["tax"] = tax.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Details of a segment of a flight; a segment is one or more consecutive legs
 * on the same flight. For example a hypothetical flight ZZ001, from DFW to OGG,
 * would have one segment with two legs: DFW to HNL (leg 1), HNL to OGG (leg 2),
 * and DFW to OGG (legs 1 and 2).
 */
class SegmentInfo {
  /** The booking code or class for this segment. */
  core.String bookingCode;
  /** The number of seats available in this booking code on this segment. */
  core.int bookingCodeCount;
  /** The cabin booked for this segment. */
  core.String cabin;
  /** In minutes, the duration of the connection following this segment. */
  core.int connectionDuration;
  /** The duration of the flight segment in minutes. */
  core.int duration;
  /** The flight this is a segment of. */
  FlightInfo flight;
  /** An id uniquely identifying the segment in the solution. */
  core.String id;
  /**
   * Identifies this as a segment object. A segment is one or more consecutive
   * legs on the same flight. For example a hypothetical flight ZZ001, from DFW
   * to OGG, could have one segment with two legs: DFW to HNL (leg 1), HNL to
   * OGG (leg 2). Value: the fixed string qpxexpress#segmentInfo.
   */
  core.String kind;
  /** The legs composing this segment. */
  core.List<LegInfo> leg;
  /**
   * The solution-based index of a segment in a married segment group. Married
   * segments can only be booked together. For example, an airline might report
   * a certain booking code as sold out from Boston to Pittsburgh, but as
   * available as part of two married segments Boston to Chicago connecting
   * through Pittsburgh. For example content of this field, consider the
   * round-trip flight ZZ1 PHX-PHL ZZ2 PHL-CLT ZZ3 CLT-PHX. This has three
   * segments, with the two outbound ones (ZZ1 ZZ2) married. In this case, the
   * two outbound segments belong to married segment group 0, and the return
   * segment belongs to married segment group 1.
   */
  core.String marriedSegmentGroup;
  /**
   * Whether the operation of this segment remains subject to government
   * approval.
   */
  core.bool subjectToGovernmentApproval;

  SegmentInfo();

  SegmentInfo.fromJson(core.Map _json) {
    if (_json.containsKey("bookingCode")) {
      bookingCode = _json["bookingCode"];
    }
    if (_json.containsKey("bookingCodeCount")) {
      bookingCodeCount = _json["bookingCodeCount"];
    }
    if (_json.containsKey("cabin")) {
      cabin = _json["cabin"];
    }
    if (_json.containsKey("connectionDuration")) {
      connectionDuration = _json["connectionDuration"];
    }
    if (_json.containsKey("duration")) {
      duration = _json["duration"];
    }
    if (_json.containsKey("flight")) {
      flight = new FlightInfo.fromJson(_json["flight"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("leg")) {
      leg = _json["leg"].map((value) => new LegInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("marriedSegmentGroup")) {
      marriedSegmentGroup = _json["marriedSegmentGroup"];
    }
    if (_json.containsKey("subjectToGovernmentApproval")) {
      subjectToGovernmentApproval = _json["subjectToGovernmentApproval"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bookingCode != null) {
      _json["bookingCode"] = bookingCode;
    }
    if (bookingCodeCount != null) {
      _json["bookingCodeCount"] = bookingCodeCount;
    }
    if (cabin != null) {
      _json["cabin"] = cabin;
    }
    if (connectionDuration != null) {
      _json["connectionDuration"] = connectionDuration;
    }
    if (duration != null) {
      _json["duration"] = duration;
    }
    if (flight != null) {
      _json["flight"] = (flight).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (leg != null) {
      _json["leg"] = leg.map((value) => (value).toJson()).toList();
    }
    if (marriedSegmentGroup != null) {
      _json["marriedSegmentGroup"] = marriedSegmentGroup;
    }
    if (subjectToGovernmentApproval != null) {
      _json["subjectToGovernmentApproval"] = subjectToGovernmentApproval;
    }
    return _json;
  }
}

/** The price of this segment. */
class SegmentPricing {
  /**
   * A segment identifier unique within a single solution. It is used to refer
   * to different parts of the same solution.
   */
  core.String fareId;
  /** Details of the free baggage allowance on this segment. */
  core.List<FreeBaggageAllowance> freeBaggageOption;
  /**
   * Identifies this as a segment pricing object, representing the price of this
   * segment. Value: the fixed string qpxexpress#segmentPricing.
   */
  core.String kind;
  /** Unique identifier in the response of this segment. */
  core.String segmentId;

  SegmentPricing();

  SegmentPricing.fromJson(core.Map _json) {
    if (_json.containsKey("fareId")) {
      fareId = _json["fareId"];
    }
    if (_json.containsKey("freeBaggageOption")) {
      freeBaggageOption = _json["freeBaggageOption"].map((value) => new FreeBaggageAllowance.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("segmentId")) {
      segmentId = _json["segmentId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fareId != null) {
      _json["fareId"] = fareId;
    }
    if (freeBaggageOption != null) {
      _json["freeBaggageOption"] = freeBaggageOption.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (segmentId != null) {
      _json["segmentId"] = segmentId;
    }
    return _json;
  }
}

/**
 * Information about a slice. A slice represents a traveller's intent, the
 * portion of a low-fare search corresponding to a traveler's request to get
 * between two points. One-way journeys are generally expressed using 1 slice,
 * round-trips using 2. For example, if a traveler specifies the following trip
 * in a user interface:
 * | Origin | Destination | Departure Date | | BOS | LAX | March 10, 2007 | |
 * LAX | SYD | March 17, 2007 | | SYD | BOS | March 22, 2007 |
 * then this is a three slice trip.
 */
class SliceInfo {
  /** The duration of the slice in minutes. */
  core.int duration;
  /**
   * Identifies this as a slice object. A slice represents a traveller's intent,
   * the portion of a low-fare search corresponding to a traveler's request to
   * get between two points. One-way journeys are generally expressed using 1
   * slice, round-trips using 2. Value: the fixed string qpxexpress#sliceInfo.
   */
  core.String kind;
  /** The segment(s) constituting the slice. */
  core.List<SegmentInfo> segment;

  SliceInfo();

  SliceInfo.fromJson(core.Map _json) {
    if (_json.containsKey("duration")) {
      duration = _json["duration"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("segment")) {
      segment = _json["segment"].map((value) => new SegmentInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (duration != null) {
      _json["duration"] = duration;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (segment != null) {
      _json["segment"] = segment.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Criteria a desired slice must satisfy. */
class SliceInput {
  /**
   * Slices with only the carriers in this alliance should be returned; do not
   * use this field with permittedCarrier. Allowed values are ONEWORLD, SKYTEAM,
   * and STAR.
   */
  core.String alliance;
  /** Departure date in YYYY-MM-DD format. */
  core.String date;
  /** Airport or city IATA designator of the destination. */
  core.String destination;
  /**
   * Identifies this as a slice input object, representing the criteria a
   * desired slice must satisfy. Value: the fixed string qpxexpress#sliceInput.
   */
  core.String kind;
  /**
   * The longest connection between two legs, in minutes, you are willing to
   * accept.
   */
  core.int maxConnectionDuration;
  /** The maximum number of stops you are willing to accept in this slice. */
  core.int maxStops;
  /** Airport or city IATA designator of the origin. */
  core.String origin;
  /**
   * A list of 2-letter IATA airline designators. Slices with only these
   * carriers should be returned.
   */
  core.List<core.String> permittedCarrier;
  /**
   * Slices must depart in this time of day range, local to the point of
   * departure.
   */
  TimeOfDayRange permittedDepartureTime;
  /**
   * Prefer solutions that book in this cabin for this slice. Allowed values are
   * COACH, PREMIUM_COACH, BUSINESS, and FIRST.
   */
  core.String preferredCabin;
  /**
   * A list of 2-letter IATA airline designators. Exclude slices that use these
   * carriers.
   */
  core.List<core.String> prohibitedCarrier;

  SliceInput();

  SliceInput.fromJson(core.Map _json) {
    if (_json.containsKey("alliance")) {
      alliance = _json["alliance"];
    }
    if (_json.containsKey("date")) {
      date = _json["date"];
    }
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxConnectionDuration")) {
      maxConnectionDuration = _json["maxConnectionDuration"];
    }
    if (_json.containsKey("maxStops")) {
      maxStops = _json["maxStops"];
    }
    if (_json.containsKey("origin")) {
      origin = _json["origin"];
    }
    if (_json.containsKey("permittedCarrier")) {
      permittedCarrier = _json["permittedCarrier"];
    }
    if (_json.containsKey("permittedDepartureTime")) {
      permittedDepartureTime = new TimeOfDayRange.fromJson(_json["permittedDepartureTime"]);
    }
    if (_json.containsKey("preferredCabin")) {
      preferredCabin = _json["preferredCabin"];
    }
    if (_json.containsKey("prohibitedCarrier")) {
      prohibitedCarrier = _json["prohibitedCarrier"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alliance != null) {
      _json["alliance"] = alliance;
    }
    if (date != null) {
      _json["date"] = date;
    }
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxConnectionDuration != null) {
      _json["maxConnectionDuration"] = maxConnectionDuration;
    }
    if (maxStops != null) {
      _json["maxStops"] = maxStops;
    }
    if (origin != null) {
      _json["origin"] = origin;
    }
    if (permittedCarrier != null) {
      _json["permittedCarrier"] = permittedCarrier;
    }
    if (permittedDepartureTime != null) {
      _json["permittedDepartureTime"] = (permittedDepartureTime).toJson();
    }
    if (preferredCabin != null) {
      _json["preferredCabin"] = preferredCabin;
    }
    if (prohibitedCarrier != null) {
      _json["prohibitedCarrier"] = prohibitedCarrier;
    }
    return _json;
  }
}

/** Tax data. */
class TaxData {
  /** An identifier uniquely identifying a tax in a response. */
  core.String id;
  /**
   * Identifies this as a tax data object, representing some tax. Value: the
   * fixed string qpxexpress#taxData.
   */
  core.String kind;
  /** The name of a tax. */
  core.String name;

  TaxData();

  TaxData.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Tax information. */
class TaxInfo {
  /** Whether this is a government charge or a carrier surcharge. */
  core.String chargeType;
  /** The code to enter in the ticket's tax box. */
  core.String code;
  /** For government charges, the country levying the charge. */
  core.String country;
  /**
   * Identifier uniquely identifying this tax in a response. Not present for
   * unnamed carrier surcharges.
   */
  core.String id;
  /**
   * Identifies this as a tax information object. Value: the fixed string
   * qpxexpress#taxInfo.
   */
  core.String kind;
  /** The price of the tax in the sales or equivalent currency. */
  core.String salePrice;

  TaxInfo();

  TaxInfo.fromJson(core.Map _json) {
    if (_json.containsKey("chargeType")) {
      chargeType = _json["chargeType"];
    }
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("salePrice")) {
      salePrice = _json["salePrice"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (chargeType != null) {
      _json["chargeType"] = chargeType;
    }
    if (code != null) {
      _json["code"] = code;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (salePrice != null) {
      _json["salePrice"] = salePrice;
    }
    return _json;
  }
}

/** Two times in a single day defining a time range. */
class TimeOfDayRange {
  /** The earliest time of day in HH:MM format. */
  core.String earliestTime;
  /**
   * Identifies this as a time of day range object, representing two times in a
   * single day defining a time range. Value: the fixed string
   * qpxexpress#timeOfDayRange.
   */
  core.String kind;
  /** The latest time of day in HH:MM format. */
  core.String latestTime;

  TimeOfDayRange();

  TimeOfDayRange.fromJson(core.Map _json) {
    if (_json.containsKey("earliestTime")) {
      earliestTime = _json["earliestTime"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("latestTime")) {
      latestTime = _json["latestTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (earliestTime != null) {
      _json["earliestTime"] = earliestTime;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (latestTime != null) {
      _json["latestTime"] = latestTime;
    }
    return _json;
  }
}

/** Trip information. */
class TripOption {
  /** Identifier uniquely identifying this trip in a response. */
  core.String id;
  /**
   * Identifies this as a trip information object. Value: the fixed string
   * qpxexpress#tripOption.
   */
  core.String kind;
  /** Per passenger pricing information. */
  core.List<PricingInfo> pricing;
  /**
   * The total price for all passengers on the trip, in the form of a currency
   * followed by an amount, e.g. USD253.35.
   */
  core.String saleTotal;
  /** The slices that make up this trip's itinerary. */
  core.List<SliceInfo> slice;

  TripOption();

  TripOption.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("pricing")) {
      pricing = _json["pricing"].map((value) => new PricingInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("saleTotal")) {
      saleTotal = _json["saleTotal"];
    }
    if (_json.containsKey("slice")) {
      slice = _json["slice"].map((value) => new SliceInfo.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (pricing != null) {
      _json["pricing"] = pricing.map((value) => (value).toJson()).toList();
    }
    if (saleTotal != null) {
      _json["saleTotal"] = saleTotal;
    }
    if (slice != null) {
      _json["slice"] = slice.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A QPX Express search request, which will yield one or more solutions. */
class TripOptionsRequest {
  /**
   * Do not return solutions that cost more than this price. The alphabetical
   * part of the price is in ISO 4217. The format, in regex, is
   * [A-Z]{3}\d+(\.\d+)? Example: $102.07
   */
  core.String maxPrice;
  /** Counts for each passenger type in the request. */
  PassengerCounts passengers;
  /** Return only solutions with refundable fares. */
  core.bool refundable;
  /**
   * IATA country code representing the point of sale. This determines the
   * "equivalent amount paid" currency for the ticket.
   */
  core.String saleCountry;
  /**
   * The slices that make up the itinerary of this trip. A slice represents a
   * traveler's intent, the portion of a low-fare search corresponding to a
   * traveler's request to get between two points. One-way journeys are
   * generally expressed using one slice, round-trips using two. An example of a
   * one slice trip with three segments might be BOS-SYD, SYD-LAX, LAX-BOS if
   * the traveler only stopped in SYD and LAX just long enough to change planes.
   */
  core.List<SliceInput> slice;
  /** The number of solutions to return, maximum 500. */
  core.int solutions;
  /** IATA country code representing the point of ticketing. */
  core.String ticketingCountry;

  TripOptionsRequest();

  TripOptionsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("maxPrice")) {
      maxPrice = _json["maxPrice"];
    }
    if (_json.containsKey("passengers")) {
      passengers = new PassengerCounts.fromJson(_json["passengers"]);
    }
    if (_json.containsKey("refundable")) {
      refundable = _json["refundable"];
    }
    if (_json.containsKey("saleCountry")) {
      saleCountry = _json["saleCountry"];
    }
    if (_json.containsKey("slice")) {
      slice = _json["slice"].map((value) => new SliceInput.fromJson(value)).toList();
    }
    if (_json.containsKey("solutions")) {
      solutions = _json["solutions"];
    }
    if (_json.containsKey("ticketingCountry")) {
      ticketingCountry = _json["ticketingCountry"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxPrice != null) {
      _json["maxPrice"] = maxPrice;
    }
    if (passengers != null) {
      _json["passengers"] = (passengers).toJson();
    }
    if (refundable != null) {
      _json["refundable"] = refundable;
    }
    if (saleCountry != null) {
      _json["saleCountry"] = saleCountry;
    }
    if (slice != null) {
      _json["slice"] = slice.map((value) => (value).toJson()).toList();
    }
    if (solutions != null) {
      _json["solutions"] = solutions;
    }
    if (ticketingCountry != null) {
      _json["ticketingCountry"] = ticketingCountry;
    }
    return _json;
  }
}

/** A QPX Express search response. */
class TripOptionsResponse {
  /** Informational data global to list of solutions. */
  Data data;
  /**
   * Identifies this as a QPX Express trip response object, which consists of
   * zero or more solutions. Value: the fixed string qpxexpress#tripOptions.
   */
  core.String kind;
  /** An identifier uniquely identifying this response. */
  core.String requestId;
  /** A list of priced itinerary solutions to the QPX Express query. */
  core.List<TripOption> tripOption;

  TripOptionsResponse();

  TripOptionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("data")) {
      data = new Data.fromJson(_json["data"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("requestId")) {
      requestId = _json["requestId"];
    }
    if (_json.containsKey("tripOption")) {
      tripOption = _json["tripOption"].map((value) => new TripOption.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (data != null) {
      _json["data"] = (data).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (requestId != null) {
      _json["requestId"] = requestId;
    }
    if (tripOption != null) {
      _json["tripOption"] = tripOption.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A QPX Express search request. */
class TripsSearchRequest {
  /**
   * A QPX Express search request. Required values are at least one adult or
   * senior passenger, an origin, a destination, and a date.
   */
  TripOptionsRequest request;

  TripsSearchRequest();

  TripsSearchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("request")) {
      request = new TripOptionsRequest.fromJson(_json["request"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (request != null) {
      _json["request"] = (request).toJson();
    }
    return _json;
  }
}

/** A QPX Express search response. */
class TripsSearchResponse {
  /**
   * Identifies this as a QPX Express API search response resource. Value: the
   * fixed string qpxExpress#tripsSearch.
   */
  core.String kind;
  /** All possible solutions to the QPX Express search request. */
  TripOptionsResponse trips;

  TripsSearchResponse();

  TripsSearchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("trips")) {
      trips = new TripOptionsResponse.fromJson(_json["trips"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (trips != null) {
      _json["trips"] = (trips).toJson();
    }
    return _json;
  }
}
