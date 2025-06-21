# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-06-21
### Changed
- expose tcp port 10003 instead of 10001 & 10002
  (postsrsd v2 uses "socketmap:" instead of "tcp:" tables)
- configure postsrsd to listen on all ipv4 interfaces (default: loopback only)
- umask `0077` to initialize secrets file with minimal permissions

### Removed
- environment variables `SRS_DOMAIN` & `SRS_SECRET`
  (settings moved to `/etc/postsrsd/postsrsd.conf` in postsrsd v2)

### Fixed
- dockerfile: prefix registry in `FROM` instruction (for `podman build`)
- set path of secrets file in postsrsd's config file (compatible with v[0.1.1])

## [0.1.1] - 2019-08-19
### Fixed
- init secrets file on startup if non-existing
  ("500 No secrets in SRS configuration.")

## [0.1.0] - 2019-08-19
- postsrsd on alpine 3.10
- set domain via `$SRS_DOMAIN`

[Unreleased]: https://github.com/fphammerle/docker-postsrsd/compare/1.0.0...HEAD
[1.0.0]: https://github.com/fphammerle/docker-postsrsd/compare/0.1.1...1.0.0
[0.1.1]: https://github.com/fphammerle/docker-postsrsd/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/fphammerle/docker-postsrsd/releases/tag/0.1.0
