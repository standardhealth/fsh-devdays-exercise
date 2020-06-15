// Note that these definitions are not a 100% match to the original US Core
// Patient Profile and related artifiacts. Certain fields such as "mapping"
// or "short" are not always faithfully recreated here.

Alias: USPS = https://www.usps.com
Alias: BCP = urn:ietf:bcp:47
Alias: GENDER = http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender
Alias: NULL = http://terminology.hl7.org/CodeSystem/v3-NullFlavor
Alias: RACE = urn:oid:2.16.840.1.113883.6.238


Profile: USCorePatientProfile
Parent: Patient
Id: us-core-patient
Title: "US Core Patient Profile"
Description: "Defines constraints and extensions on the patient resource for the minimal 
set of data to query and retrieve patient demographic information."
* extension contains 
    USCoreRaceExtension named race 0..1 MS and
    USCoreEthnicityExtension named ethnicity 0..1 MS and
    USCoreBirthSexExtension named birthsex 0..1 MS
* identifier 1..* MS
* identifier.system 1..1 MS
* identifier.value 1..1 MS
* identifier.value ^short = "The value that is unique within the system"
* name 1..* MS
* name obeys us-core-8
* name.family MS
* name.family ^condition = "us-core-8"
* name.given MS
* name.given ^condition = "us-core-8"
* telecom MS
* telecom.system 1..1 MS
* telecom.value 1..1 MS
* telecom.use MS
* gender 1..1 MS
* birthDate MS
* address MS
* address.line MS
* address.city MS
* address.state MS
* address.state from UspsTwoLetterAlphabeticCodes (extensible)
* address.postalCode MS
* address.postalCode ^short = "US Zip Codes"
* address.period MS
* communication MS
* communication.language MS
* communication.language from LanguageCodesWithLanguageAndOptionallyARegionModifier (extensible)


Extension: USCoreRaceExtension
Id: us-core-race
Title: "US Core Race Extension"
Description: "Concepts classifying the person into a named category of humans sharing common 
history, traits, geographical origin or nationality.  The race codes used to 
represent these concepts are based upon the 
[CDC Race and Ethnicity Code Set Version 1.0](http://www.cdc.gov/phin/resources/vocabulary/index.html) 
which includes over 900 concepts for representing race and ethnicity of which 921 reference race.  
The race concepts are grouped by and pre-mapped to the 5 OMB race categories: 
  - American Indian or Alaska Native
  - Asian
  - Black or African American
  - Native Hawaiian or Other Pacific Islander
  - White."
* . ^short = "US Core Race Extension"
* extension contains 
    ombCategory 0..5 MS and
    detailed 0..* and
    text 1..1 MS
* extension[ombCategory].value[x] only Coding
* extension[ombCategory].valueCoding 1..1
* extension[ombCategory].valueCoding from OmbRaceCategories
* extension[detailed].value[x] only Coding
* extension[detailed].valueCoding 1..1
* extension[detailed].valueCoding from DetailedRace
* extension[text].value[x] only string
* extension[text].valueString 1..1


Extension: USCoreEthnicityExtension
Id: us-core-ethnicity
Title: "US Core Ethnicity Extension"
Description: "Concepts classifying the person into a named category of humans sharing common history,
traits, geographical origin or nationality.  The ethnicity codes used to represent these 
concepts are based upon the 
[CDC ethnicity and Ethnicity Code Set Version 1.0](http://www.cdc.gov/phin/resources/vocabulary/index.html) 
which includes over 900 concepts for representing race and ethnicity of which 43 reference ethnicity.  
The ethnicity concepts are grouped by and pre-mapped to the 2 OMB ethnicity categories: 
  - Hispanic or Latino 
  - Not Hispanic or Latino."
* . ^short = "US Core Ethnicity Extension"
* extension contains 
    ombCategory 0..1 MS and
    detailed 0..* and
    text 1..1 MS
* extension[ombCategory].value[x] only Coding
* extension[ombCategory].valueCoding 1..1
* extension[ombCategory].valueCoding from OmbEthnicityCategories
* extension[detailed].value[x] only Coding
* extension[detailed].valueCoding 1..1
* extension[detailed].valueCoding from DetailedEthnicity
* extension[text].value[x] only string
* extension[text].valueString 1..1


Extension: USCoreBirthSexExtension
Id: us-core-birthsex
Title: "US Core Birth Sex Extension"
Description: "A code classifying the person's sex assigned at birth  as specified by the 
[Office of the National Coordinator for Health IT (ONC)](https://www.healthit.gov/newsroom/about-onc). 
This extension aligns with the C-CDA Birth Sex Observation (LOINC 76689-9)."
* . ^short = "US Core Birth Sex Extension"
* value[x] only code
* valueCode from BirthSex


Invariant: us-core-8
Description: "Patient.name.given or Patient.name.family or both SHALL be present"
Severity: #error
Expression: "family.exists() or given.exists()"
XPath: "f:given or f:family"


ValueSet: OmbRaceCategories
Id: omb-race-category
Title: "OMB Race Categories"
Description: "The codes for the concepts 'Unknown' and  'Asked but no answer' and the the 
codes for the five race categories - 'American Indian' or 'Alaska Native', 
'Asian', 'Black or African American', 'Native Hawaiian or Other Pacific Islander', 
and 'White' - as defined by the [OMB Standards for Maintaining, Collecting, and 
Presenting Federal Data on Race and Ethnicity, Statistical Policy Directive No. 15, 
as revised, October 30, 1997](https://www.whitehouse.gov/omb/fedreg_1997standards)" 
* RACE#1002-5	"American Indian or Alaska Native"
* RACE#2028-9	"Asian"
* RACE#2054-5	"Black or African American"
* RACE#2076-8	"Native Hawaiian or Other Pacific Islander"
* RACE#2106-3	"White"
* NULL#UNK "Unknown"
* NULL#ASKU "Asked but no answer"


ValueSet: DetailedRace
Id: detailed-race
Title: "Detailed Race"
Description: "The 900+ [CDC Race codes](http://www.cdc.gov/phin/resources/vocabulary/index.html) 
that are grouped under one of the 5 OMB race category codes."
* codes from system RACE where concept is-a #1000-9
* exclude RACE#1002-5
* exclude RACE#2028-9
* exclude RACE#2054-5
* exclude RACE#2076-8
* exclude RACE#2106-3


ValueSet: OmbEthnicityCategories
Id: omb-ethnicity-category
Title: "OMB Ethnicity Categories"
Description: "The codes for the ethnicity categories - 'Hispanic or Latino' and 'Non Hispanic or Latino' -
as defined by the 
[OMB Standards for Maintaining, Collecting, and Presenting Federal Data on Race and Ethnicity, Statistical Policy Directive No. 15, as revised, October 30, 1997](https://www.whitehouse.gov/omb/fedreg_1997standards)."
* RACE#2135-2 "Hispanic or Latino"
* RACE#2186-5 "Non Hispanic or Latino"


ValueSet: DetailedEthnicity
Id: detailed-ethnicity
Title: "Detailed Ethnicity"
Description: "The 41 
[CDC ethnicity codes](http://www.cdc.gov/phin/resources/vocabulary/index.html) 
that are grouped under one of the 2 OMB ethnicity category codes."
* codes from system RACE where concept is-a #2133-7
* exclude RACE#2135-2
* exclude RACE#2186-5


ValueSet: BirthSex
Id: birthsex
Title: "Birth Sex"
Description: "Codes for assigning sex at birth as specified by the 
[Office of the National Coordinator for Health IT (ONC)](https://www.healthit.gov/newsroom/about-onc)"
* GENDER#M "Male"
* GENDER#F "Female"
* NULL#UNK "Unknown"


ValueSet: LanguageCodesWithLanguageAndOptionallyARegionModifier
Id: simple-language
Title: "Language codes with language and optionally a region modifier"
Description: "This value set includes codes from [BCP-47](http://tools.ietf.org/html/bcp47). 
This value set matches the ONC 2015 Edition LanguageCommunication data element
value set within C-CDA to use a 2 character language code if one exists,   
and a 3 character code if a 2 character code does not exist. It points back to 
[RFC 5646](https://tools.ietf.org/html/rfc5646), however only the language codes 
are required, all other elements are optional."
* codes from system BCP where 
    ext-lang exists false and
    script exists false and 
    variant exists false and
    extension exists false and
    private-use exists false


ValueSet: UspsTwoLetterAlphabeticCodes
Id: us-core-usps-state
Title: "USPS Two Letter Alphabetic Codes"
Description: "This value set defines two letter USPS alphabetic codes."
* USPS#AK	"Alaska"
* USPS#AL	"Alabama"
* USPS#AR	"Arkansas"
* USPS#AS	"American Samoa"
* USPS#AZ	"Arizona"
* USPS#CA	"California"
* USPS#CO	"Colorado"
* USPS#CT	"Connecticut"
* USPS#DC	"District of Columbia"
* USPS#DE	"Delaware"
* USPS#FL	"Florida"
* USPS#FM	"Federated States of Micronesia"
* USPS#GA	"Georgia"
* USPS#GU	"Guam"
* USPS#HI	"Hawaii"
* USPS#IA	"Iowa"
* USPS#ID	"Idaho"
* USPS#IL	"Illinois"
* USPS#IN	"Indiana"
* USPS#KS	"Kansas"
* USPS#KY	"Kentucky"
* USPS#LA	"Louisiana"
* USPS#MA	"Massachusetts"
* USPS#MD	"Maryland"
* USPS#ME	"Maine"
* USPS#MH	"Marshall Islands"
* USPS#MI	"Michigan"
* USPS#MN	"Minnesota"
* USPS#MO	"Missouri"
* USPS#MP	"Northern Mariana Islands"
* USPS#MS	"Mississippi"
* USPS#MT	"Montana"
* USPS#NC	"North Carolina"
* USPS#ND	"North Dakota"
* USPS#NE	"Nebraska"
* USPS#NH	"New Hampshire"
* USPS#NJ	"New Jersey"
* USPS#NM	"New Mexico"
* USPS#NV	"Nevada"
* USPS#NY	"New York"
* USPS#OH	"Ohio"
* USPS#OK	"Oklahoma"
* USPS#OR	"Oregon"
* USPS#PA	"Pennsylvania"
* USPS#PR	"Puerto Rico"
* USPS#PW	"Palau"
* USPS#RI	"Rhode Island"
* USPS#SC	"South Carolina"
* USPS#SD	"South Dakota"
* USPS#TN	"Tennessee"
* USPS#TX	"Texas"
* USPS#UM	"U.S. Minor Outlying Islands"
* USPS#UT	"Utah"
* USPS#VA	"Virginia"
* USPS#VI	"Virgin Islands of the U.S."
* USPS#VT	"Vermont"
* USPS#WA	"Washington"
* USPS#WI	"Wisconsin"
* USPS#WV	"West Virginia"
* USPS#WY	"Wyoming"