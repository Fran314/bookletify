# Bookletify

A python utility to rearrange the pages of a pdf so that it can be printed with
two pages per page (effectively A5 pages) and then folded and bound into a
booklet.

The code assumes that the resulting pdf gets printed in "two-sided-long-edge"
mode, meaning: two-sided pages, bound along the long edge (as you would with a
normal portrait A4 stack of sheets).

In practice, the code turns the following (where `#N` means page number, and the
arrow points to UP):

```
┌──────────┐┌──────────┐ ┌──────────┐┌──────────┐
│          ││          │ │          ││          │
│          ││          │ │          ││          │
│   #1 ^   ││   #2 ^   │ │   #3 ^   ││   #4 ^   │
│          ││          │ │          ││          │
│          ││          │ │          ││          │
│          ││          │ │          ││          │
└──────────┘└──────────┘ └──────────┘└──────────┘
┌──────────┐┌──────────┐ ┌──────────┐┌──────────┐
│          ││          │ │          ││          │
│          ││          │ │          ││          │
│   #5 ^   ││   #6 ^   │ │   #7 ^   ││   #8 ^   │
│          ││          │ │          ││          │
│          ││          │ │          ││          │
│          ││          │ │          ││          │
└──────────┘└──────────┘ └──────────┘└──────────┘
```

into the following (where `->` and `<-` point to where UP is according to how
the page is rotated):

```
┌──────────┐┌──────────┐ ┌──────────┐┌──────────┐
│          ││          │ │          ││          │
│  #8 ->   ││  <- #7   │ │  #6 ->   ││  <- #5   │
│          ││          │ │          ││          │
├──────────┤├──────────┤ ├──────────┤├──────────┤
│          ││          │ │          ││          │
│  #1 ->   ││  <- #2   │ │  #3 ->   ││  <- #4   │
│          ││          │ │          ││          │
└──────────┘└──────────┘ └──────────┘└──────────┘
```

If the pages are printed like this, stacked and folded, they read correctly from
1 to 8 in the correct orientation

## Usage

```
USAGE: bookletify [-h] [-q] [-s SIZE] [-b MARGIN] [-t T T T T] input output

positional arguments:
  input                 name of the input file to bookletify. Use '-' to read
                        file from stdin
  output                name of the output file to write to. Use '-' to write
                        to stdout

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress stdout. Not suppressed if the flag this flag
                        is absent. Automatically suppressed if output is '-'
                        (see output), to avoid broken pdfs
  -s, --size SIZE       set final paper size. Possible values: 'A0', ..., 'A8'
                        or 'C4'. Default value is 'A4'
  -b, --binding-margin MARGIN
                        internal margin for the binding, expressed in
                        millimeters relative to the final paper size (ie: half
                        of the height of the paper size specified by --size).
                        Set to 0 to disable. This setting is independent to
                        the trim setting, ie: increasing or decreasing this
                        margin does not trim any content on the final pdf, the
                        content gets scaled down (or up) to fit to the final
                        width minus the binding margin. Default value is 8
  -t, --trim T T T T    margins to trim, expressed in millimeters relative to
                        the original page size, as: top right bottom left.
                        This setting is independent to the binding margin, ie:
                        first the trim is applied, then the trimmed content
                        gets scaled up (or down) to the full height and width,
                        minus the binding margin. Changing the trim does not
                        increase or decrease the final binding margin. A
                        negative trim adds an empty border on that side.
                        Default value is 0 0 0 0
```
