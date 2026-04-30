Keeping the NVIDIA drivers + CUDA working on groot

* Install the NVIDIA drivers from rpmfusion:

  ```
  dnf install akmod-nvidia xorg-x11-drv-nvidia-3:580.142-1.fc43.x86_64
  ```

* Don't update CUDA -- keep it on 12.9.  For this you use
  `cuda-fedora41.repo` and do:

  ```
  dnf install cuda-toolkit
  ```

  critically, this installed `xorg-x11-drv-nvidia-cuda`, which rpmfusion
  does not provide

* You need to compile using GCC 14, which requires the packages
  `gcc14` and `gcc14-c++`.

