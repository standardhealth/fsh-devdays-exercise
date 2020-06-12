# FHIR Shorthand: Let’s Build!

_Track Leads: Mark Kramer and Chris Moesel_

During this Let’s Build! session, you will learn how to build a small FHIR Implementation Guide (IG)
by attempting to reproduce the US Core Patient profile using FHIR Shorthand.

After completing this tutorial, you will be able to:

- Install SUSHI, the reference implementation FHIR Shorthand compiler
- Define basic profiles, extensions, and value sets using FHIR Shorthand
- Build a human-readable FHIR IG using SUSHI and the HL7 FHIR IG Publisher

### Requirements

- A text editor (recommended: [VS Code](https://code.visualstudio.com/) with
  [vscode-language-fsh](https://marketplace.visualstudio.com/items?itemName=kmahalingam.vscode-language-fsh)
  extension)
- [Node.js LTS](https://nodejs.org/en/download/) – needed to install and run SUSHI
- [SUSHI](http://hl7.org/fhir/uv/shorthand/2020May/sushi.html#step-2-install-sushi) – needed to
  compile FSH into valid FHIR definitions
- [OpenJDK 8](https://adoptopenjdk.net/?variant=openjdk8&jvmVariant=hotspot) (or licensed
  [Oracle JDK](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html)) – needed
  to run HL7 IG Publisher
- [Ruby and Jekyll](https://jekyllrb.com/docs/installation/) – needed to run HL7 IG Publisher

### Resources

- [FHIR Shorthand May 2020 ballot specification](http://hl7.org/fhir/uv/shorthand/2020May/)
- [US Core STU 3.1 Patient profile](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.html)
- [FSH Let’s Build Starter Project](https://github.com/standardhealth/fsh-devdays-exercise/releases/tag/v0.0.1)

## Exercise: US Core Patient Implementation Guide

In this exercise, we will review the US Core Patient profile and attempt to recreate it using FHIR
Shorthand. Novice IG authors may choose to implement only part of the profile, while braver souls
(with lots of free time on their hands) can attempt to implement the entire profile, including the
extensions and value sets that it references. In all cases (novice or expert), IG authors will build
a minimal Implementation Guide that allows them to view their profile in a web browser.

> NOTE: This exercise is designed to get progressively more complicated. We recommend all
> participants attempt to complete at least the first seven steps. Steps eight and above are
> there for those who like to squeeze every last penny out of their DevDays registration fee!

## Step 1: Install the required software

First, install the required software listed in the "Requirements" section above. Follow the links
to find the download packages and/or installation instructions.

Ensure that your version of SUSHI is 0.13.0 or later. Earlier versions will not work! To check:
1. Open a command prompt using _Command Prompt_ on Windows or _Terminal_ on Mac.
2. Run the command: `sushi -v`

## Step 2: Review the basics of FHIR Shorthand

If you did not have an opportunity to attend the FHIR Shorthand tutorial, read the
[FHIR Shorthand Overview](http://hl7.org/fhir/uv/shorthand/2020May/index.html) to get a basic
understanding of FHIR Shorthand.

## Step 3: Download and Open the FSH Let’s Build Starter Project

Download the
[FSH Let’s Build Starter Project](https://github.com/standardhealth/fsh-devdays-exercise/releases/tag/v0.0.1)
and unzip it to a location of your choice. This project provides a common project structure for FSH
projects, allowing you to get started right away! You didn't really want to start _from scratch_,
did you?

Open this folder in your favorite text editor (we recommend [VS Code](https://code.visualstudio.com/)
if you don’t have one) or file explorer (if your favorite text editor cannot open folders). The
starter project contains the following file structure:

```
.
├── .gitignore                // Ignores generated build artifacts in git so you don't check them in
├── README.md                 // The file you are reading now (!)
├── _genonce.bat              // Win: Runs the IG Publisher on your IG
├── _genonce.sh               // Mac: Runs the IG Publisher on your IG
├── _updatePublisher.bat      // Win: Downloads and/or updates your IG Publisher jar
├── _updatePublisher.sh       // Mac: Downloads and/or updates your IG Publisher jar
└── fsh
    ├── config.yaml           // The SUSHI config file, pre-configured for US Core Patient IG
    ├── ig-data
    │   └── input
    │       └── pagecontent
    │           └── index.md  // Markdown file providing the contents of your IG's home page
    └── patient.fsh           // The FSH file where you will write your FSH definitions
```

## Step 4: Review the US Core Patient profile

Open the [US Core Patient profile](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.html)
documentation in your web browser. Scroll down to the _Formal Views of Profile Content_ section and
click on the _Differential View_ tab. This tab shows how the US Core Patient profile differs from
the base [FHIR R4 Patient resource](http://hl7.org/fhir/R4/patient.html). Review this tab to become
familiar with the differences, such as the extensions, cardinality constraints, "must support"
flags, value set bindings, and invariants (e.g., us-core-8). You will need to come back to this view
as you build your profile in FHIR Shorthand.

Now click on the [JSON tab](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.json.html)
at the top of the page to see the JSON StructureDefinition representation of this profile. Briefly
thank your lucky stars that you get to write FHIR Shorthand instead of having to write this file.
Once you feel appropriately grateful, use your browser to search for the word "differential" in the
JSON definition. The JSON contents below the word "differential" are the computer-friendly
representation of the same differences that you just viewed in the human-friendly _Differential
View_ tab. Hopefully you won’t need to look at this again (but you might).

## Step 5: Create a basic USCorePatientProfile definition

In this step, we’ll create a USCorePatientProfile definition with some high-level metadata. Start by
opening the file _fsh/patient.fsh_ in your text editor. Now, create a profile with the following
high-level metadata:

| Metadata    | Value                                                                                                                                         |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| Name        | USCorePatientProfile                                                                                                                          |
| Parent      | Patient                                                                                                                                       |
| Id          | us-core-patient                                                                                                                               |
| Title       | US Core Patient Profile                                                                                                                       |
| Description | Defines constraints and extensions on the patient resource for the minimal set of data to query and retrieve patient demographic information. |

New to FHIR Shorthand? See
[Defining Profiles](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-profiles) in
the FHIR Shorthand specification for help. Look at the example _(you can thank us later)_. While
that example provides all of the keywords _(and more!)_ that you’ll need for this step, you can also
reference the [Keywords](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#keywords-1) section
to see all of the available keywords.

## Step 6: Run SUSHI and build your Implementation Guide

### Step 6.1: Run SUSHI

Think you nailed Step 5? Great! Now it's time to prove it! Follow these steps to run SUSHI on your
FSH project:

1. Open a command prompt using _Command Prompt_ on Windows or _Terminal_ on Mac.
2. Change directories to the unzipped `fsh-devdays-exercise-0.0.1` folder (commandline newbies:
   [Win](https://www.howtogeek.com/659411/how-to-change-directories-in-command-prompt-on-windows-10/)
   / [Mac](https://www.macworld.com/article/2042378/master-the-command-line-navigating-files-and-folders.html))
3. Run the following command: `sushi`
   - If you haven’t installed SUSHI yet, see the links at the top of this document

If you wrote valid FHIR Shorthand, SUSHI will exit reporting 1 profile with 0 errors and 0
warnings. You also get a free random fish pun to celebrate with!

```
╔════════════════════════ SUSHI RESULTS ══════════════════════════╗
║ ╭──────────┬────────────┬───────────┬─────────────┬───────────╮ ║
║ │ Profiles │ Extensions │ ValueSets │ CodeSystems │ Instances │ ║
║ ├──────────┼────────────┼───────────┼─────────────┼───────────┤ ║
║ │    1     │     0      │     0     │      0      │     0     │ ║
║ ╰──────────┴────────────┴───────────┴─────────────┴───────────╯ ║
║                                                                 ║
║ See SUSHI-GENERATED-FILES.md for details on generated IG files. ║
╠═════════════════════════════════════════════════════════════════╣
║ O-fish-ally error free!                0 Errors      0 Warnings ║
╚═════════════════════════════════════════════════════════════════╝
```

If you got any errors, they'll be reflected in the log and counted in the summary. You will also
get a random fish pun as pun-ishment (see what we did there?). Go back to your text editor, fix
your FSH definition, and try again!

When the build is successful, go ahead and take a look at the new "input" folder in your project.
This contains the files that SUSHI generated for you. It is (confusingly) called "input" because it
is _input_ to the HL7 FHIR IG Publisher. So... let’s try running the IG Publisher now!

### Step 6.2: Run the HL7 IG Publisher

To run the HL7 IG Publisher on the files that SUSHI just generated:

1. Go back to your command prompt (which should still be in your unzipped project directory)
2. Run the following command to download the HL7 IG Publisher jar (Java Archive)
   - Windows: `_updatePublisher.bat`
   - Mac: `./_updatePublisher.sh`
3. Once it is downloaded, run the following command to invoke the HL7 IG Publisher:
   - Windows: `_genonce.bat`
   - Mac: `./_genonce.sh`
   - If you haven’t installed Java yet, see the links at the top of this document

If the IG Publisher completed successfully, you should now be able to view your human-readable
Implementation Guide by opening the file at _output/index.html_ in your web browser. Click
"Artifacts" in the menu, then click on the link for your USCorePatientProfile. Since we haven’t
authored any constraints yet, this profile won’t be very exciting, but we’re on our way to bigger
and better things!

> NOTE: Throughout this exercise, you may notice slight differences in how your profile is
> visually rendered compared to the one in US Core. This is expected because we are using a
> different template than US Core and the IG Publisher has also changed how it renders several
> things since US Core was last published.

> NOTE 2: You also might notice that the IG Publisher runs SUSHI too! That's OK -- and in fact, it's
> quite helpful when you're using the Auto IG Builder. If the redundancy really bothers you, then...
> we're sorry. Hopefully you'll find that learning to live with it builds character. There is a
> secret to make it stop, but you'll need to find it on your own in the
> [Zulip](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/way.20to.20turn.20off.20sushi.20and.20just.20run.20the.20publisher/near/199808387)
> jungle.

## Step 7: Add Cardinality Constraints and Must Support Flags

Review the _Differential View_ in the
[US Core Patient profile](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.html#formal-views-of-profile-content).
Note the _Flags_ and _Card._ columns. The red _S_ in the _Flags_ column indicates "must support".
Update your US Core Patient profile FSH definition with rules constraining the cardinality and
applying "must support" flags as seen in the _Differential View_. For now, _ignore_ the first
three extensions (indicated by a green icon).

We'll give you one rule to get started:

```
* identifier 1..* MS
```

You may want to consult the following sections of the FHIR Shorthand specification for more help:

- [Nested Element Paths](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#nested-element-paths)
- [Cardinality Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#cardinality-rules)
- [Flag Assignment Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#flag-assignment-rules)

When you’re done, run SUSHI and the IG Publisher again (Step 6) and review the output, paying
special attention to cardinality and flags in your profile’s _Differential View_.

> NOTE: You may notice that some of your cardinalities are in a gray font; this is because they do
> not actually differ from the base Patient resource. Unfortunately, the US Core Patient profile
> rendering does not properly show this – but now that you know which ones _aren’t_ really
> different, you can remove those cardinality constraints from your FSH if you wish! Go ahead and
> do it; deleting code feels _great_!

## Step 8: Create and Bind the UspsTwoLetterAlphabeticCodes value set

If you made it this far, pat yourself on the back -- you now know enough about SUSHI and FHIR
Shorthand to capture (and then lose) your friends' interest at the next cocktail party! If you
want to stop here, you can walk away feeling good about what you've done. If you want to keep
going, we're about to dive into some more fun waters with value sets and extensions!

Review the _Differential View_ in the
[US Core Patient profile](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.html#formal-views-of-profile-content)
and note the "Binding" on _address.state_. A value set binding provides a set of codes that are
valid for a given element. Click on the binding link:
[USPS Two Letter Alphabetic Codes](http://hl7.org/fhir/us/core/STU3.1/ValueSet-us-core-usps-state.html).

Your goal for this step of the exercise is to create a miniature version of this value set with only
a few codes (because who has time to write 50+ of these?).

### Step 8.1: Create the basic UspsTwoLetterAlphabeticCodes value set metadata

Like we did for patient, start off by creating the basic ValueSet definition with the following
metadata:

| Metadata    | Value                                                    |
| ----------- | -------------------------------------------------------- |
| Name        | UspsTwoLetterAlphabeticCodes                             |
| Id          | us-core-usps-state                                       |
| Title       | USPS Two Letter Alphabetic Codes                         |
| Description | This value set defines two letter USPS alphabetic codes. |

Need some help? Check out
[Defining Value Sets](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-value-sets)
in the FHIR Shorthand specification.

### Step 8.2: Specify codes belonging to the UspsTwoLetterAlphabeticCodes value set

Next, specify a small set of codes as members of the value set. Since New England is obviously the
best region of the United States, we'll specify the codes for `ME`, `VT`, `NH`, `MA`, `RI`, and
`CT`.

> HINT: To make this easier (and save some typing), you'll probably want to define an alias for
> the USPS code system: `https://www.usps.com`.

You may want to consult the following sections of the FHIR Shorthand specification for more help:

- [Defining Aliases](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-aliases)
- [Coding](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#coding)
- [Defining Value Sets](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-value-sets)

Now run SUSHI again and fix any reported errors. Once SUSHI succeeds, run the IG Publisher again and
reload your IG in your web browser. Click on the "Artifacts" menu item and notice that the
USPS Two Letter Alphabetic Codes value set is now listed. Click it to review its contents.

> NOTE: You will likely see an error in the _Expansion_ section of your value set page saying:
> "No Expansion for this valueset (not supported by Publication Tooling)". This is expected, as the
> IG Publisher does not formally support the USPS code system. Please do not blame SUSHI. SUSHI is
> sad too when this happens.

### Step 8.3: Bind address.state to the UspsTwoLetterAlphabeticCodes value set

Now that you've defined the UspsTwoLetterAlphabeticCodes value set, bind it to the _address.state_
element in your USCorePatientProfile definition using the binding strength:
[extensible](http://hl7.org/fhir/R4/terminologies.html#extensible).

You may want to consult the following section of the FHIR Shorthand specification for more help:

- [Value Set Binding Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#value-set-binding-rules)

By now you know the drill: run SUSHI, fix errors as necessary, run the IG Publisher, and check out
the output in your browser. If it works, you should see the UspsTwoLetterAlphabeticCodes binding
in your USCorePatientProfile!

### Step 9: Create the USCoreBirthSexExtension extension

It's tough to write a robust implementation guide without needing to create at least one extension.
The US Core Patient profile uses three! In this step, we'll create the simplest of the three
extensions: USCoreBirthSexExtension.

Review the _Differential View_ in the
[US Core Patient profile](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.html#formal-views-of-profile-content)
and note the third extension element: `us-core-birthsex`. Click on the extension URL
[http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex](http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex)
to view the extension definition.

### Step 9.1: Create the basic USCoreBirthSexExtension metadata

Creating an extension is very similar to creating a profile, but in this case, you're actually
profiling the [Extension](http://hl7.org/fhir/R4/extensibility.html#Extension) type, so there
are only a few fields to keep track of, primarily: `value[x]` and `extension`. Start off by creating
the basic Extension definition with the following metadata:

| Metadata    | Value                                                                                                                                                                                                                                                         |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Name        | USCoreBirthSexExtension                                                                                                                                                                                                                                       |
| Id          | us-core-birthsex                                                                                                                                                                                                                                              |
| Title       | US Core Birth Sex Extension                                                                                                                                                                                                                                   |
| Description | A code classifying the person's sex assigned at birth as specified by the \[Office of the National Coordinator for Health IT (ONC)](https://www.healthit.gov/newsroom/about-onc). This extension aligns with the C-CDA Birth Sex Observation (LOINC 76689-9). |

If you need help, take a look at
[Defining Extensions](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-extensions)
in the FHIR Shorthand specification.

### Step 9.2: Constrain the USCoreBirthSexExtension value

In FHIR, extensions can be simple or complex. The USCoreBirthSexExtension is a simple extension.
Simple extensions allow for a single value by constraining the `value[x]` field to a particular type
(or types), optionally specifying additional constraints on the `value[x]` type(s).

To complete this step of the exercise, create a rule that constrains USCoreBirthSexExtension's
`value[x]` element to only allow the type: `code`. Then create a new
[BirthSex](http://hl7.org/fhir/us/core/STU3.1/ValueSet-birthsex.html) value set and bind
USCoreBirthSexExtension's value to it using the binding strength:
[required](http://hl7.org/fhir/R4/terminologies.html#required).

You've created and bound value sets before (easy peasy!), but this step requires some new tricks:
constraining choices to specific types and specifying FSH paths for specific choice types. You may
want to consult the following sections of the FHIR Shorthand specification for help:

- [Data Type Restriction Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#data-type-restriction-rules)
- [Data Type Choice [x] Paths](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#data-type-choice-x-paths)

As usual, use SUSHI and the IG Publisher to check your work.

## Step 10: Add the USCoreBirthSexExtension to USCorePatientProfile

Now that you have that fancy new extension, it's time to use it! Go back to your
USCorePatientProfile and constrain the _extension_ element to indicate that it should contain an
optional USCoreBirthSexExtension with the local name _birthsex_.

You may want to consult the following section of the FHIR Shorthand specification for more help:

- [Extension Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#extension-rules)
  - _WARNING: The example for adding a standalone extension defined in the same FSH tank has a bug;
    it fails to provide a local name for the extension. See the other examples for guidance on how
    to do that. (Sorry, no one's perfect; not even us)._

Now, go the extra step and flag that extension as "must support" in USCorePatientProfile. Once you
think you've got it right, use SUSHI and the IG Publisher to test it out.

> NOTE: We don't want to bore you too much with the details, but in case you're interested,
> adding extensions is a special case of _slicing_ in FHIR. If you thought slicing was only for
> ninjas, well... _you_ are now a ninja!

## Step 11: Add short descriptions to identifier.value and address.postalCode

You've worked hard to get this far, so we thought we'd lob you a softball for this next one.
You may have noticed that a couple of elements in the _Differential View_ of the
[US Core Patient profile](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.html#formal-views-of-profile-content)
have a short description in the right-hand column. If you didn't notice, go look again.

Profile authors can affect what is displayed in the right-hand column of an element by providing a
_short_ description in that element's metadata within the StructureDefiniton. _(By the way, have we
told you yet that the formal specification format for resources, profiles, and extensions is called
a StructureDefinition? If not, now you know -- another cool tidbit to remember for those epic
cocktail party conversations!)._ In FHIR Shorthand, you can use the caret (`^`) to set a metadata
value directly in the StructureDefinition.

For this step, use the special `^` syntax to set the `short` metadata value for these elements in
the USCorePatientProfile:

| Element            | Short                                       |
| ------------------ | ------------------------------------------- |
| identifier.value   | The value that is unique within the system. |
| address.postalCode | US Zip Codes                                |

You may want to consult the following section of the FHIR Shorthand specification for help:

- [Structure Definition Escape Paths](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#structure-definition-escape-paths)

If you're one of those _curious_ people, take a look at the elements in
[ElementDefinition](http://hl7.org/fhir/R4/elementdefinition.html). These are the paths you can
access _after_ the `^` when setting metadata directly on an element in a profile.

> NOTE: You can also use `^` to set high-level metadata in the
> [StructureDefinition](http://hl7.org/fhir/R4/structuredefinition.html), like _publisher_,
> _contact_, and _jurisdiction_. Lucky for you, you don't need to do that here because we set that
> information globally in the _config.yaml_ file and used special parameters to apply those values
> to all definitions in the IG. Check out that _config.yaml_ file. Snazzy!

## Step 12: Finish the profile. Achieve world peace. Take a nap.

At some point, every good parent takes the training wheels off the bike, takes a deep breath, and
gives their kid a shove. This is that moment for us. You've proven you can do this, so now you're
on your own. If you're up to the challenge, finish this profile:

- Create the [USCoreRaceExtension](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-race.html)
  and its associated value sets
- Create the [USCoreEthnicityExtension](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-ethnicity.html)
  and its associated value sets
- Create the [LanguageCodesWithLanguageAndOptionallyARegionModifier](http://hl7.org/fhir/us/core/STU3.1/ValueSet-simple-language.html)
  value set and bind it to _communication.language_ with binding strength: `extensible`
- Create the _us-core-8_ invariant with the following metadata and apply it to _name_:

  | Metadata    | Value                                                              |
  | ----------- | ------------------------------------------------------------------ |
  | Name        | us-core-8                                                          |
  | Severity    | #error                                                             |
  | Description | Patient.name.given or Patient.name.family or both SHALL be present |
  | Expression  | family.exists() or given.exists()                                  |
  | XPath       | f:given or f:family                                                |

To get to the finish line, you may want to consult the following sections in the FHIR Shorthand
specification:

- [Defining Extensions](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-extensions)
- [Extension Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#extension-rules)
- [Extension Paths](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#extension-paths)
- [Defining Value Sets](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-value-sets)
- [Defining Invariants](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-invariants)
- [Invariant Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#invariant-rules)

There's still more you can do to achieve complete parity with the US Core Patient profile (such
as defining [Mappings](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#defining-mappings)),
but honestly... haven't you had enough? I'm starting to think you need a hobby.
