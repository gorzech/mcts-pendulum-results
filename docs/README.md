# Results for the inverted pendulum analysis using MCTS

Now two sets of results are available - for the single and double pendulum!

 - [Single pendulum](#single_pendulum)
 - [Double pendulum](#double_pendulum)

## Results for the single pendulum {#single_pendulum}

| Link                     | Reward                                        | Force \[N\] | Steps \[-\] |
| ------------------------ | --------------------------------------------- | ----------- | ----------- |
| [D](Plots_fig_sp_D.md)   | Default.                                      | 10          | 200         |
| [E](Plots_fig_sp_E.md)   | Default.                                      | 10          | **500**     |
| [F](Plots_fig_sp_F.md)   | Reward 1 or 0.5 (half-way).                   | 10          | 200         |
| [G](Plots_fig_sp_G.md)   | 0.5 cart penalty linear.                      | 10          | 200         |
| [H](Plots_fig_sp_H.md)   | Reward 1 or 0.5.                              | 10          | **500**     |
| [I](Plots_fig_sp_I.md)   | Default.                                      | **12**      | 200         |
| [J](Plots_fig_sp_J.md)   | Cart penalty linear.                          | 10          | 200         |
| [K](Plots_fig_sp_K.md)   | Cart penalty linear.                          | **12**      | 200         |
| [L](Plots_fig_sp_L.md)   | Angle penalty linear.                         | 10          | 200         |
| [M](Plots_fig_sp_M.md)   | Angle penalty linear.                         | **12**      | 200         |
| [N](Plots_fig_sp_N.md)   | Tip penalty 0.5/0.5.                          | 10          | 200         |
| [O](Plots_fig_sp_O.md)   | Default.                                      | **15**      | 200         |
| [P](Plots_fig_sp_P.md)   | Penalty linear 0.5 cart 0.5 angle             | 10          | 200         |
| [Q](Plots_fig_sp_Q.md)   | Penalty linear 0.25 cart 0.75 angle           | 10          | 200         |
| [R](Plots_fig_sp_R.md)   | Penalty linear 0.75 cart 0.25 angle           | 10          | 200         |
| [S](Plots_fig_sp_S.md)   | Angle penalty quadratic                       | 10          | 200         |
| [T](Plots_fig_sp_T.md)   | Cart penalty quadratic                        | 10          | 200         |
| [U](Plots_fig_sp_U.md)   | Penalty quadratic 0.25/0.75 cart/angle        | 10          | 200         |
| [V](Plots_fig_sp_V.md)   | Angle penalty sqrt                            | 10          | 200         |
| [W](Plots_fig_sp_W.md)   | Penalty power 6/2 0.25/0.75 cart/angle        | 10          | 200         |
| [X](Plots_fig_sp_X.md)   | Tip penalty 0.25/0.75 x-tip/y-tip             | 10          | 200         |
| [Y](Plots_fig_sp_Y.md)   | Angle penalty exp(-(a / 5) ^ 2)               | 10          | 200         |
| [Z](Plots_fig_sp_Z.md)   | Penalty linear 0.25 cart 0.75 angle           | 10          | **500**     |
| [AA](Plots_fig_sp_AA.md) | Angle penalty exp(-(a / 3) ^ 2)               | 10          | 200         |
| [AB](Plots_fig_sp_AB.md) | Angle penalty exp(-(a / 8) ^ 2)               | 10          | 200         |
| [AC](Plots_fig_sp_AC.md) | Angle penalty exp(-(a / 2) ^ 2)               | 10          | 200         |
| [AD](Plots_fig_sp_AD.md) | Angle penalty exp(-(a / 1) ^ 2)               | 10          | 200         |
| [AE](Plots_fig_sp_AE.md) | 0.75exp(-(a/0.25at)^2)+0.25exp(-(x/0.25xt)^2) | 10          | 200         |
| [AF](Plots_fig_sp_AF.md) | 0.75exp(-(a/0.25at)^2)+0.25exp(-(x/0.2xt)^2)  | 10          | 200         |
| [AG](Plots_fig_sp_AG.md) | 0.75exp(-(a/0.25at)^2)+0.25exp(-(x/0.3xt)^2)  | 10          | 200         |
| [AH](Plots_fig_sp_AH.md) | 0.85exp(-(a/0.25at)^2)+0.15exp(-(x/0.25xt)^2) | 10          | 200         |
| [AI](Plots_fig_sp_AI.md) | 0.75exp(-(a/0.25at)^2)+0.25exp(-(x/0.1xt)^2)  | 10          | 200         |
| [AJ](Plots_fig_sp_AJ.md) | 0.75exp(-(a/0.25at)^2)+0.25exp(-(x/0.4xt)^2)  | 10          | 200         |
| [AK](Plots_fig_sp_AK.md) | exp(-(ytip/0.25ymax)^2)                       | 10          | 200         |
| [AL](Plots_fig_sp_AL.md) | exp(-(ytip/0.1ymax)^2)                        | 10          | 200         |
| [AM](Plots_fig_sp_AM.md) | exp(-(ytip/0.4ymax)^2)                        | 10          | 200         |
| [AN](Plots_fig_sp_AN.md) | AA with more steps                            | 10          | **500**     |
| [AO](Plots_fig_sp_AO.md) | AH with more steps                            | 10          | **500**     |
| [AP](Plots_fig_sp_AP.md) | 0.95exp(-(a/0.25at)^2)+0.05exp(-(x/0.25xt)^2) | 10          | **500**     |
| [AQ](Plots_fig_sp_AQ.md) | AL with more steps                            | 10          | **500**     |
| [AR](Plots_fig_sp_AR.md) | θ>2 ? exp(-((θ-2)/3)^2) : exp(-((θ-2)/5 ^2))  | 10          | 200         |

## Results for the double pendulum {#double_pendulum}

A default parameter range is γ = 0.7:0.05:1.0 and Cₚ = [0, 2, 4, 8, 16, 32]

The full test case (as in C) has a few more exploration parameters included. Therefore, for the full range, we have:
γ = 0.7:0.05:1.0 and Cₚ = [0, 2, 4, 8, 16, 32, 64, 128, 256]

| Link                     | Reward                                                  | Force \[N\] | Steps \[-\] | Notes                               |
| ------------------------ | ------------------------------------------------------- | ----------- | ----------- | ----------------------------------- |
| [C](Plots_fig_dp_C.md)   | Default.                                                | 20          | 200         | Full range                          |
| [D](Plots_fig_dp_D.md)   | Default.                                                | **25**      | 200         | Full range                          |
| [E](Plots_fig_dp_E.md)   | Angle penalty exp(-(a/0.25at) ^ 2)                      | 20          | 200         | Full range                          |
| [F](Plots_fig_dp_F.md)   | 0.75exp(-(a/0.25at)^2)+0.25exp(-(x/0.25xt)^2)           | 20          | 200         | Full range                          |
| [G](Plots_fig_dp_G.md)   | exp(-(ytip/0.25ymax)^2)                                 | 20          | 200         | Full range                          |
| [H](Plots_fig_dp_H.md)   | Angle penalty exp(-(a/0.1at) ^ 2)                       | 20          | 200         | Full range                          |
| [I](Plots_fig_dp_I.md)   | Angle penalty exp(-(a/0.4at) ^ 2)                       | 20          | 200         | Full range                          |
| [J](Plots_fig_dp_J.md)   | exp(-(ytip/0.1ymax)^2)                                  | 20          | 200         | Full range                          |
| [K](Plots_fig_dp_K.md)   | exp(-(ytip/0.4ymax)^2)                                  | 20          | 200         | Full range                          |
| [L](Plots_fig_dp_L.md)   | Angle penalty exp(-(a/0.55at) ^ 2)                      | 20          | 200         | Full range                          |
| [M](Plots_fig_dp_M.md)   | 0.95exp(-(ytip/0.25ymax)^2)+0.05exp(-(xtip/0.25xmax)^2) | 20          | 200         | Full range                          |
| [N](Plots_fig_dp_N.md)   | Angle penalty exp(-(a/0.7at) ^ 2)                       | 20          | 200         | Full range                          |
| [O](Plots_fig_dp_O.md)   | 0.8exp(-(ytip/0.25ymax)^2)+0.2exp(-(xtip/0.25xmax)^2)   | 20          | 200         | Full range                          |
| [P](Plots_fig_dp_P.md)   | Angle penalty exp(-(a/0.85at) ^ 2)                      | 20          | 200         | Full range                          |
| [Q](Plots_fig_dp_Q.md)   | 0.85exp(-(a/0.7at)^2)+0.15exp(-(x/0.7xt)^2)             | 20          | 200         | Full range                          |
| [R](Plots_fig_dp_R.md)   | 0.7exp(-(a/0.7at)^2)+0.3exp(-(x/0.7xt)^2)               | 20          | 200         | Full range                          |
| [S](Plots_fig_dp_S.md)   | 0.85exp(-(a/0.7at)^2)+0.15exp(-(x/0.4xt)^2)             | 20          | 200         | Full range                          |
| [T](Plots_fig_dp_T.md)   | C with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0                    |
| [U](Plots_fig_dp_U.md)   | N with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0                    |
| [V](Plots_fig_dp_V.md)   | Q with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0, Cₚ = [16, 32, 64] |
| [W](Plots_fig_dp_W.md)   | R with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0, Cₚ = [16, 32, 64] |
| [X](Plots_fig_dp_X.md)   | S with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0, Cₚ = [16, 32, 64] |
| [Y](Plots_fig_dp_Y.md)   | G with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0                    |
| [Z](Plots_fig_dp_Z.md)   | O with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0, Cₚ = [16, 32]     |
| [AA](Plots_fig_dp_AA.md) | M with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0                    |
| [AB](Plots_fig_dp_AB.md) | J with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0                    |
| [AC](Plots_fig_dp_AC.md) | K with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0                    |
