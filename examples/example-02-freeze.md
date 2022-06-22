# Quarto Actions: Freeze

If you have computational content which cannot be executed in a CI environment (because of eg security or authentication), you can use Quarto's freezer feature.

## Enabling Freeze

Add the following to your `_quarto.yml` configuration:

```yaml
execute:
  freeze: true  # never re-execute computational content during project render
```

This stops quarto from re-executing computational cells during a project render.

## Adding the frozen contents to the repository

From a computer that is capable of executing the content, run a file-specific `render` command to create or update the frozen content

```bash
$ quarto render name-of-file-to-freeze.qmd
```

Note that you have to specify the particular file: a call to `quarto render` will _not_ re-execute the content when `freeze: true`. Finally, add the `_freeze` top-level directory to version control so that GitHub Actions can reuse the executed content.

## More

See [Quarto's documentation on freeze](https://quarto.org/docs/projects/code-execution.html#freeze) for more.