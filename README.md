# Cardano Node Docker

[Cardano Node Docker](https://github.com/tiredpixel/cardano-node-docker) is an independent container image for [Cardano Node](https://github.com/input-output-hk/cardano-node), created by [Nic Williams](https://www.tiredpixel.com/) for the high-availability [[CRAB](https://www.tiredpixel.com/cardano-stake-pool/)] stake pool 🦀. As such, it is an opinionated alternative to the official container images.

If you'd like to keep up-to-date with my work across this and other projects, you might like to sign up to my [newsletter](https://www.tiredpixel.com/#newsletter).


## Images

There are two images built from this repo:

- [build](https://hub.docker.com/r/tiredpixel/cardano-node-build) (`Dockerfile`): this is an image of dependencies, such as is suitable for development; packaged images are also constructed from this, making builds more deterministic and debuggable

- [package](https://hub.docker.com/r/tiredpixel/cardano-node) (`pkg/Dockerfile`): this is an image of packaged programs, with minimal dependencies, such as is suitable for running within a deployed environment; this image requires an intermediary CI step, moving compiled binaries from the build image into this image


## Versions

Versions are in the format `x.y.z.b`, where `x.y.z` is the Cardano Node version, and `.b` is the build version. There might be multiple builds for each version, and not all versions might be built. Versions intentionally lag behind the official releases, to give me chance to perform additional QA. For example, 1.18.0 was released normally, 1.18.1 wasn't released since there was an upstream build issue and then the release was pulled anyway, 1.19.0 wasn't released for days because of an upstream build issue and then was released only with a cherry-picked patch, meaning it didn't track the official repository, but rather my own patched version.

Lots of tags are written; however, only those tagged in the above format are considered suitable for installation. Do not leave the tag implicit or use `latest` except for development or staging, since intermediate tags are almost certainly unstable; instead, specify the tag you want. This is good advice for use of containers in general. For this image, you can choose the granularity based on your preferences or deployment requirements; e.g. 1.19.0 is released under `1.19.0.0`, `1.19.0`, `1.19`, and `1`.


## Security

If you care about security, you'll very probably want to build this container image for yourself, rather than rely on what I publish to a registry. Whilst being wary of pre-compiled artefacts is always good advice, this is even more important for software with a financial incentive, such as cryptocurrency software. It is likely a matter of time before someone exploits a Cardano node by offering malicious images. Please also note that there have already been successful attacks against people in the community running stake pools with incorrectly configured orchestrator engines and firewalls. It is really very important that you are careful across all areas of your process and infrastructure, and that includes but also goes far beyond the code in these images.


## Disclaimer

Your particular attention is drawn to the disclaimers in the licence. For example, if this image doesn't work and causes your Cardano node downtime, or if there's a bug which affects your stake pool pledge or financial returns, or if a vulnerability allows it or your broader server or other software to get hacked, this is not my issue. I might be sympathetic, but it certainly isn't my fault. Please conduct your own due diligence for everything, including whether you want to use this code at all.


## Blessing

May you find peace, and help others to do likewise.


## Contact

[tiredpixel.com](https://www.tiredpixel.com/) · [tp@tiredpixel.com](mailto:tp@tiredpixel.com)

LinkedIn: [in/nic-williams](https://www.linkedin.com/in/nic-williams/) · Twitter: [tiredpixel](https://twitter.com/tiredpixel) · GitHub: [tiredpixel](https://github.com/tiredpixel)


## Licence

Copyright © 2020 [Nic Williams](https://www.tiredpixel.com/). It is free software, released under the Apache License, Version 2.0, and may be redistributed under the terms specified in `LICENSE`.

Note that the following components might be included within compiled artefacts such as container images, and have their own licences with which you must comply:

- [Cardano Node](https://github.com/input-output-hk/cardano-node)

- [Libsodium](https://github.com/input-output-hk/libsodium)
