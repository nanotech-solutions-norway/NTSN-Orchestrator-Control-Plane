# Connector Capability Map — 01:55, 29.06.2026

## GitHub connector fetchable evidence

The GitHub connector can normally fetch:

- repository metadata;
- committed README files;
- committed documentation;
- workflow YAML files;
- source files;
- issues and pull requests;
- pull request diffs;
- workflow job steps when run and job identifiers are known;
- workflow logs when job identifiers are known;
- workflow artifacts when run and artifact identifiers are known and still available.

## Evidence requiring upload or separate provider bridge

The following evidence is not reliably available through the GitHub connector alone:

- Wix DNS exports or screenshots;
- Domeneshop server file tree;
- SQL schema exports or validation reports;
- server runtime configuration evidence;
- GitHub environment configuration screenshots or summaries;
- provider dashboard screenshots;
- expired GitHub Actions artifacts;
- downloaded workflow log archives not addressable through run/job identifiers;
- Custom GPT instructions and Actions schemas unless committed or pasted;
- MCP client configuration unless committed in sanitized form.

## Rule

Connector data is evidence. It does not override approved repository policy unless the relevant policy file explicitly classifies it as approved.
