---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
title: Summary of MCTS results
usemathjax: true
notusewidecss: false
---

# Results for the inverted pendulum analysis using MCTS

Now two sets of results are available - for the single and double pendulum!

 - [Single pendulum](#single_pendulum)
 - [Double pendulum](#double_pendulum)

## Rewards used in the investigations

\begin{equation}
    R=1
    \label{eq:constant}
\end{equation}

\begin{equation}
    R = 1 - w\frac{1}{n}\sum_{i=1}^n \left( \frac{|\theta_i|}{\theta_{\max}} \right)^{p_{\theta}} - (1-w)\left( \frac{|x|}{x_{\max}} \right)^{p_x}
    \label{eq: reward polynomial angle}
\end{equation}

## Results for the single pendulum {#single_pendulum}

| Results   | Name  | Steps \[-\] |
| --------- | ----- | ----------- |
{% for item in site.data.single_pendulum_plots %} | [{{ item.id }}](Plots_fig_sp_{{ item.id }}.html) | {{ item.name }} | {% if item.steps == "200" %} {{ item.steps }} {% else %} **{{ item.steps }}** {% endif %} | 
{% endfor %}

## Results for the double pendulum {#double_pendulum}

A default parameter range is γ = 0.7:0.05:1.0 and Cₚ = [0, 2, 4, 8, 16, 32, 64, 128, 256]

The test cases for 500 steps are limited to γ = 0.9:0.05:1.0

| Link                     | Reward                                                  | Force \[N\] | Steps \[-\] | Notes            |
| ------------------------ | ------------------------------------------------------- | ----------- | ----------- | ---------------- |
| [C](Plots_fig_dp_C.md)   | Default.                                                | 20          | 200         |                  |
| [D](Plots_fig_dp_D.md)   | Default.                                                | **25**      | 200         |                  |
| [E](Plots_fig_dp_E.md)   | Angle penalty exp(-(a/0.25at) ^ 2)                      | 20          | 200         |                  |
| [F](Plots_fig_dp_F.md)   | 0.75exp(-(a/0.25at)^2)+0.25exp(-(x/0.25xt)^2)           | 20          | 200         |                  |
| [G](Plots_fig_dp_G.md)   | exp(-(ytip/0.25ymax)^2)                                 | 20          | 200         |                  |
| [H](Plots_fig_dp_H.md)   | Angle penalty exp(-(a/0.1at) ^ 2)                       | 20          | 200         |                  |
| [I](Plots_fig_dp_I.md)   | Angle penalty exp(-(a/0.4at) ^ 2)                       | 20          | 200         |                  |
| [J](Plots_fig_dp_J.md)   | exp(-(ytip/0.1ymax)^2)                                  | 20          | 200         |                  |
| [K](Plots_fig_dp_K.md)   | exp(-(ytip/0.4ymax)^2)                                  | 20          | 200         |                  |
| [L](Plots_fig_dp_L.md)   | Angle penalty exp(-(a/0.55at) ^ 2)                      | 20          | 200         |                  |
| [M](Plots_fig_dp_M.md)   | 0.95exp(-(ytip/0.25ymax)^2)+0.05exp(-(xtip/0.25xmax)^2) | 20          | 200         |                  |
| [N](Plots_fig_dp_N.md)   | Angle penalty exp(-(a/0.7at) ^ 2)                       | 20          | 200         |                  |
| [O](Plots_fig_dp_O.md)   | 0.8exp(-(ytip/0.25ymax)^2)+0.2exp(-(xtip/0.25xmax)^2)   | 20          | 200         |                  |
| [P](Plots_fig_dp_P.md)   | Angle penalty exp(-(a/0.85at) ^ 2)                      | 20          | 200         |                  |
| [Q](Plots_fig_dp_Q.md)   | 0.85exp(-(a/0.7at)^2)+0.15exp(-(x/0.7xt)^2)             | 20          | 200         |                  |
| [R](Plots_fig_dp_R.md)   | 0.7exp(-(a/0.7at)^2)+0.3exp(-(x/0.7xt)^2)               | 20          | 200         |                  |
| [S](Plots_fig_dp_S.md)   | 0.85exp(-(a/0.7at)^2)+0.15exp(-(x/0.4xt)^2)             | 20          | 200         |                  |
| [T](Plots_fig_dp_T.md)   | C with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [U](Plots_fig_dp_U.md)   | N with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [V](Plots_fig_dp_V.md)   | Q with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [W](Plots_fig_dp_W.md)   | R with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [X](Plots_fig_dp_X.md)   | S with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [Y](Plots_fig_dp_Y.md)   | G with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [Z](Plots_fig_dp_Z.md)   | O with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [AA](Plots_fig_dp_AA.md) | M with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [AB](Plots_fig_dp_AB.md) | J with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
| [AC](Plots_fig_dp_AC.md) | K with more steps                                       | 20          | **500**     | γ = 0.9:0.05:1.0 |
