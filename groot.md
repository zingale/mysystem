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

* patch `/usr/local/cuda-12.9/targets/x86_64-linux/include/crt/math_functions.h`

  ```
  597c597
  < extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ double                 rsqrt(double x)  noexcept(true);
  ---
  > extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ double                 rsqrt(double x);
  621c621
  < extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ float                  rsqrtf(float x)  noexcept(true);
  ---
  > extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ float                  rsqrtf(float x);
  2556c2556
  < extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ double                 sinpi(double x) noexcept(true);
  ---
  > extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ double                 sinpi(double x);
  2579c2579
  < extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ float                  sinpif(float x) noexcept(true);
  ---
  > extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ float                  sinpif(float x);
  2601c2601
  < extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ double                 cospi(double x) noexcept(true);
  ---
  > extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ double                 cospi(double x);
  2623c2623
  < extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ float                  cospif(float x) noexcept(true);
  ---
  > extern __DEVICE_FUNCTIONS_DECL__ __device_builtin__ float                  cospif(float x);
  ```

  This is due to GLIBC updates.

* You need to compile using GCC 14, which requires the packages
  `gcc14` and `gcc14-c++`
