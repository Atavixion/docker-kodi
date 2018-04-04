# ehough/docker-kodi

Dockerized Kodi with audio and video.

![Kodi screenshot](https://kodi.wiki/images/3/33/Estuary-home.jpg "Kodi screenshot")

## Why?

This is the only setup that offers a fully-functional, Dockerized Kodi installation complete with audio and video.

This project is in an early stage of development, but has been operating on the author's HTPC for a long time without issue. Contributions and suggestions are welcome.

## Features

* audio and video via [x11docker](https://github.com/mviereck/x11docker/)
* optional OpenGL hardware video acceleration
* sound via [ALSA or PulseAudio](https://kodi.wiki/view/Linux_audio)
* simple, Ubuntu-based image that adheres to the [official Kodi installation instructions](https://kodi.wiki/view/HOW-TO:Install_Kodi_for_Linux#Installing_Kodi_on_Ubuntu-based_distributions)
* clean shutdown of Kodi when its container is terminated

## Host Requirements

The Docker **host** will need the following:

1. **Linux**

   Though not extensively tested yet, this project should work on any Linux distribution. Windows support is not yet implemented.
   
1. **A connected display and speaker(s)**

   If you're looking for a headless Kodi installation, look elsewhere!
   
## Host Installation

You will need to ensure that the following items are available on the Docker host:
   
1. **[X](https://www.x.org/) or [Wayland](https://wayland.freedesktop.org/)**

   Ensure that the packages for an X or Wayland server are present. Please consult your OS's documentation if you're not sure what to install. A display server does *not* need to be running ahead of time.

1. **[x11docker](https://github.com/mviereck/x11docker/)**

   `x11docker` allows Docker-based applications to utilize X and/or Wayland. Please follow the `x11docker` [installation instructions](https://github.com/mviereck/x11docker#installation) and ensure that you have a [working setup](https://github.com/mviereck/x11docker#examples).
   
1. **[`docker-kodi.sh`](https://github.com/ehough/docker-kodi/blob/master/docker-kodi.sh)**
   
   This required Bash script allows you to cleanly start and stop the Kodi container. There are (at least) two ways
   to download and install this script:
   
   * If you have Git, you can clone this repo anywhere on your host:
   
         $ git clone https://github.com/ehough/docker-kodi
       
   * Alternatively, you can download the script directly and make sure that it's executable:
   
         $ wget https://raw.githubusercontent.com/ehough/docker-kodi/master/docker-kodi.sh
         $ chmod +x docker-kodi.sh
       
## Usage

`docker-kodi.sh` is a wrapper around `x11docker` and the Docker CLI. It allows you to cleanly start and stop the Kodi container.

    Usage: docker-kodi.sh [-a|--action <arg>] [-i|--image <arg>] [-h|--help] [-v|--verbose] [--] [<x11docker-argument-1>] ... [<x11docker-argument-n>] ...
        <x11docker-argument>: arguments to pass to x11docker
        -a,--action: action to perform (start, stop, or status (default: 'start')
        -i,--image: image name or identifier to execute (default: 'erichough/kodi:alsa')
        -h,--help: Prints help
        -v,--verbose: Set verbose output (can be specified multiple times to increase the effect)

### Starting Kodi

To start Kodi, invoke `docker-kodi.sh` with your desired [image](#image-tags) and arguments to `x11docker`. Arguments following the first `--` delimeter (if present) are passed directly to `x11docker`.
This gives you tremendous flexibility in configuring your environment.

e.g. for ALSA sound, no window manager, a new Xorg X server on virtual terminal 7, hardware video acceleration, a persistent Kodi home directory, and a shared read-only Docker volume for Kodi media:

    $ /path/to/docker-kodi.sh --image erichough/kodi:alsa       \
                              --                                \
                              --wm none                         \
                              --xorg                            \
                              --gpu                             \
                              --alsa                            \
                              --homedir /host/path/to/kodi/home \
                              --vt 7                            \
                              --                                \
                              -v /host/path/to/media:/media:ro
                            
Detailing the myriad of `x11docker` options is beyond the scope of this document. Please consult the [`x11docker` documentation](https://github.com/mviereck/x11docker/) to find the set of options that work for your system.

### Stopping Kodi

Kill the running `docker-kodi.sh` process. Under the hood, this will call `docker stop` on the Kodi container, which allows Kodi to shut itself down properly.

## Image Tags

* ALSA sound, Kodi Krypton
  * `erichough/kodi:latest`
  * `erichough/kodi:alsa`
  * `erichough/kodi:alsa-krypton`
  * `erichough/kodi:alsa-latest`
* PulseAudio sound, Kodi Krypton
  * `erichough/kodi:pulseaudio`
  * `erichough/kodi:pulseaudio-krypton`
  * `erichough/kodi:pulseaudio-latest`

## Contributing

Contributions are welcome! Please submit an issue or pull request.

## Future Work

* Windows support
* Kodi PVR support