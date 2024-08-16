# Emma

[![Tests](https://github.com/wwvl/Emma/actions/workflows/ci.yml/badge.svg)](https://github.com/wwvl/Emma/actions/workflows/ci.yml) [![Excavator](https://github.com/wwvl/Emma/actions/workflows/excavator.yml/badge.svg)](https://github.com/wwvl/Emma/actions/workflows/excavator.yml)

Personal bucket for [Scoop](https://scoop.sh), the Windows command-line installer.

## How do I install these manifests?

After manifests have been committed and pushed, run the following:

```pwsh
scoop bucket add Emma https://github.com/wwvl/Emma
scoop install Emma/<manifestname>
```

## How do I contribute new manifests?

To make a new manifest contribution, please read the [Contributing
Guide](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md)
and [App Manifests](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests)
wiki page.

## Copyright and License

-   Manifests in this repository are © wwvl with [MIT License](./LICENSE).
