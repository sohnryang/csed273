# CSED273: Digital System Design
> 베 릴 로 그

| Lab   | 내용                                            |
| ----- | ----------------------------------------------- |
| Lab 1 | 논리 게이트, NAND/NOR으로 AND, OR, NOT 구현하기 |
| Lab 2 | Karnaugh map을 통한 minimization                |
| Lab 3 | 디코더와 멀티플렉서                             |
| Lab 4 | 반가산기와 전가산기, 덧셈, 곱셈, 뺄셈의 구현    |
| Lab 5 | ALU, flip-flop의 구현                           |
| Lab 6 | Counter의 구현                                  |

## Tips & Tricks

- 보고서에 넣을 회로도는 손이나 파워포인트 대신 [전용 도구](https://www.circuit-diagram.org/)를 쓰는 것이 편합니다. (저는 Lab 6 보고서 쓸때까지 이걸 몰라서 고생했습니다.)
- 비바도에서 회로도를 출력할 때, 캡쳐를 할 수도 있지만 pdf로 뽑아서 보고서에 넣으면 확대해도 깨지지 않고 잘 보입니다.
  - LaTeX으로 보고서를 쓰신다면, `pdfcrop`으로 여백을 자른 뒤 `\includegraphics`로 넣으면 됩니다.
- 사용할 수 있는 베릴로그 문법이 제한되어 `generate`를 쓸 수 없는데, 반복 작업을 해야 한다면 python 코드를 적당히 작성해 반복문으로 베릴로그 코드를 만들고 복붙하는 것도 괜찮은 전략입니다.
  - HW에서도 단순 반복 작업을 할 일이 많은데, 단순 반복 작업은 가능하다면 컴퓨터한테 맡기는 것이 좋습니다.
- Apple Silicon Mac 사용자 한정으로 주의할 점이 있습니다.
  - 비바도는 애석하게도 x86-64 Windows/Linux에서만 동작합니다. 여러분이 디시설을 수강한다면 UTM으로 Windows 11 for ARM 가상 머신을 만든 다음, 거기에 비바도를 설치하셔야 합니다. [UTM의 공식 메뉴얼](https://docs.getutm.app/guides/windows/)을 참고하시면 됩니다.
  - 가상 머신에서 비바도에서 simulation을 실행하자마자 응답 없음이 뜬다면 에뮬레이션 설정 문제일 가능성이 높습니다. `C:\Xilinx\Vivado\[비바도 버전]\bin\unwrapped\win64.o`에 있는 `exe` 파일들에 대해서 [속성] :arrow_right: [호환성] :arrow_right: [에뮬레이션 설정 변경]으로 간 뒤 [고급 설정 사용]을 켜고 멀티코어 설정에서 [단일코어 작업 강제]으로 바꾸면 해결됩니다.
  - 실습이나 파이널 플젝으로 FPGA를 연결해야 한다면 드라이버를 설치해야 하는데, 비바도에 포함된 드라이버는 설치해도 동작하지 않습니다. Basys 3 보드로 실습을 수행한다면 [FTDI 공식 ARM Windows 전용 드라이버](https://ftdichip.com/wp-content/uploads/2022/02/CDM-v2.12.36.4-for-ARM64-Signed-Distributable.zip)를 직접 설치하면 됩니다.
  - Icarus Verilog가 대안으로 거론되기도 하는데, 제 경험상 같은 코드를 실행했는데도 비바도와 다른 동작을 보이는 경우가 꽤 있었습니다. 개인적으론 느리더라도 가상 머신에서 비바도를 사용하는 것을 추천합니다.
- 일반적인 코딩에서 대부분 해당되는 이야기이지만, 각각의 모듈을 작게 만들고 많이 테스트하세요.