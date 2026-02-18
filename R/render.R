#----------------------------------------------------------#
#
#
#                  Version Control FZU
#
#                  Render presentation
#
#
#                       O. Mottl
#                         2025
#
#----------------------------------------------------------#

# The QUARTO is curently unable to render into other directory.
# GitHub pages require the presentation to be in the `docs` directory.
# This is a workaround to render the presentation into the `docs`` directory

# Setup -----

library(here)
library(quarto)
library(fs)
library(qpdf)

# Render -----
quarto::quarto_render(
  input = here::here("presentation.qmd")
)

# Make PDF version -----

# decktape needs to be installed separately.
# See https://github.com/astefanutti/decktape
system2(
  command = "decktape.cmd",
  args = c(
    "reveal",
    "--fragments=true",
    "--size 1050x700",
    here::here("index.html"),
    here::here("presentation_raw.pdf")
  )
)

# compress the PDF to make it small enough to uplot to GH
qpdf::pdf_compress(
  input = here::here("presentation_raw.pdf"),
  output = here::here("presentation.pdf")
)
