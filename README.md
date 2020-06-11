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
- FSH Let’s Build Starter Project (LINK TBD)

## Exercise: US Core Patient Implementation Guide

In this exercise, we will review the US Core Patient profile and attempt to recreate it using FHIR
Shorthand. Novice IG authors may choose to implement only part of the profile, while intermediate
and advanced IG authors can attempt to implement the entire profile, including the extensions and
value sets that it references. In all cases (novice or expert), IG authors will build a minimal
Implementation Guide that allows them to view their profile in a web browser.

## Step 1: Install the required software

First, install the required software listed in the "Requirements" section above. Follow the links
to find the download packages and/or installation instructions.

## Step 2: Download and Open the FSH Let’s Build Starter Project

Download the FSH Let’s Build Starter Project (LINK TBD) and unzip it to a location of your choice.
This project provides a common project structure for FSH projects, allowing you to get started right
away! Open this folder in your favorite text editor (we recommend
[VS Code](https://code.visualstudio.com/) if you don’t have one) or file explorer (if your favorite
text editor cannot open folders).

TODO: Describe contents of starter project

## Step 3: Review the US Core Patient profile

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
View_ tab. You probably won’t need to look at this again unless you opt for some advanced exercises.

## Step 4: Create a basic USCorePatientProfile definition

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
the FHIR Shorthand specification for help. While that example provides all of the keywords you’ll
need for this step, you can also reference the
[Keywords](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#keywords-1) section to see all of
the available keywords.

## Step 5: Run SUSHI and build your Implementation Guide

Think you nailed Step 4? Great! Let’s check it! Follow these steps to run SUSHI on your FSH project:

1. Open a command prompt using _Command Prompt_ on Windows or _Terminal_ on Mac.
2. Change directories to the folder for your FSH project (commandline newbies:
   [Windows](https://www.howtogeek.com/659411/how-to-change-directories-in-command-prompt-on-windows-10/)
   / [Mac](https://www.macworld.com/article/2042378/master-the-command-line-navigating-files-and-folders.html))
3. Run the following command: `sushi`
   - If you haven’t installed SUSHI yet, see the links at the top of this document

If you wrote valid FHIR Shorthand, SUSHI should exit reporting 0 warnings, 0 errors, and 1 profile.
Congratulations! If you got any errors, hopefully they help you understand what went wrong. Go back
to your text editor, fix your FSH definition, and try again! When the build is successful, go ahead
and take a look at the _new_ input folder in your project. This contains the files that SUSHI
generated for you. It is (confusingly) called "input" because it is _input_ to the HL7 FHIR IG
Publisher. So... let’s try running the IG Publisher now!

To run the IG Publisher on the files that SUSHI just generated:

1. Go back to your command prompt (which should still be in your FSH project directory)
2. Run the following command to download the HL7 IG Publisher jar (Java Archive)
   - Windows: `_updatePublisher.bat`
   - Mac: `./_updatePublisher.sh`
3. Once it is downloaded, run the following command to invoke the HL7 IG Publisher:
   - Windows: `_genonce.bat`
   - Mac: `./_genonce.sh`
   - If you haven’t installed Java yet, see the links at the top of this document

If the IG Publisher completed successfully, you should now be able to view your human-readable
Implementation Guide by opening the file at _output/index.html_ in your web browser. Click "Artifact
Index" in the menu, then click on the link for your USCorePatientProfile. Since we haven’t authored
any constraints yet, this profile won’t be very exciting, but we’re on our way to bigger and better
things!

## Step 6: Add Cardinality Constraints and Must Support Flags

In FHIR Shorthand, constraints are defined using _rules_. In a profile definition, each _rule_
begins with an asterisk (`*`), usually followed by a _path_ and a _constraint_. For example, the
following rule constrains the Patient _identifier_ to have cardinality _1..\*_:

```
* identifier 1..*
```

This means that instances of this Patient profile must have at least one _identifier_. We can use a
similar rule to flag _identifier_ as _MustSupport_:

```
* identifier MS
```

While FHIR Shorthand usually allows only one constraint per rule, there is one exception:
cardinality and flag constraints can be combined in a single rule. Instead of the two rules above,
we can say:

```
* identifier 1..* MS
```

Review the _Differential View_ in the
[US Core Patient profile](http://hl7.org/fhir/us/core/STU3.1/StructureDefinition-us-core-patient.html#formal-views-of-profile-content).
Note the _Flags_ and _Card._ columns. The red _S_ in the _Flags_ column indicates MustSupport.
Update your US Core Patient profile FSh definition with rules constraining the cardinality and
applying _MustSupport_ flags as seen in the _Differential View_.

You may want to consult the following sections of the FHIR Shorthand specification:

- [Nested Element Paths](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#nested-element-paths)
- [Cardinality Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#cardinality-rules)
- [Flag Assignment Rules](http://hl7.org/fhir/uv/shorthand/2020May/reference.html#flag-assignment-rules)

When you’re done, run SUSHI and the IG Publisher again (Step 5) and review the output, paying
special attention to cardinality and flags in your profile’s _Differential View_.

> NOTE: You may notice that some of your cardinalities are in a gray font; this is because they do
> not actually differ from the base Patient resource. Unfortunately, the US Core Patient profile
> rendering does not properly show this – but now that you know which ones _aren’t_ really
> different, you can remove those cardinality constraints from your FSH if you wish!
