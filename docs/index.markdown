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
    \label{eq: reward 1}
\end{equation}

\begin{equation}
    R = 1 - w\frac{1}{n}\sum_{i=1}^n \left( \frac{|\theta_i|}{\theta_{\max}} \right)^{p_{\theta}} - (1-w)\left( \frac{|x|}{x_{\max}} \right)^{p_x}
    \label{eq: reward polynomial angle}
\end{equation}

\begin{equation}
    R = 1 - w \left(\frac{ | y^{e} | }{y^{e}_{\max}}\right)^{p_y} - (1-w)\left(\frac{ | x^{e} | }{x\_{\max}}\right)^{p_x}
    \label{eq: reward polynomial tip}
\end{equation}

\begin{equation}
    R =
    w \frac{1}{n}\sum_{i=1}^n
    \exp{\left[
            -\left(\frac{\theta_i}{q_{\theta}\theta_{\max}}\right)^2
            \right]}
    + (1-w) \exp{\left[ -\left(\frac{x}{q_{x}x_{\max}}\right)^2 \right]}
    \label{eq: exponential reward angle}
\end{equation}

\begin{equation}
    R = w \exp{\left[ -\left(\frac{y^{e}}{q_{y}y^{e}\_{\max}}\right)^2 \right]}
    + (1-w) \exp{\left[ -\left(\frac{x^{e}}{q_{x}x\_{\max}}\right)^2 \right]}
    \label{eq: exponential reward tip}
\end{equation}

## Results for the single pendulum {#single_pendulum}

| ID   | Name  | Steps \[-\] | Equation | \\(w\\) | \\(p_\theta\\) or \\(p_y\\) | \\(p_x\\) | \\(q_\theta\\) or \\(q_y\\) | \\(q_x\\) |
| ---- | ----- | ----------- | -------- | ----- | ----------------------- | ------- | ----------------------- | ------- |
{% for item in site.data.single_pendulum_plots %} | [{{ item.id }}](Plots_fig_sp_{{ item.id }}.html) | {{ item.name }} | {% if item.steps == "200" %} {{ item.steps }} {% else %} **{{ item.steps }}** {% endif %} | {{ item.equation }} | {{ item.w }} | {{ item.p_theta }} | {{ item.p_x }} | {{ item.q_theta }} | {{ item.q_x }} |
{% endfor %}

## Results for the double pendulum {#double_pendulum}

A default parameter range is γ = 0.7:0.05:1.0 and Cₚ = [0, 2, 4, 8, 16, 32, 64, 128, 256]

The test cases for 500 steps are limited to γ = 0.9:0.05:1.0

| ID   | Name  | Steps \[-\] | Equation | \\(w\\) | \\(q_\theta\\) or \\(q_y\\) | \\(q_x\\) | Notes            |
| ---- | ----- | ----------- | -------- | ------- | --------------------------- | --------- | ---------------- |
{% for item in site.data.double_pendulum_plots %} | [{{ item.id }}](Plots_fig_sp_{{ item.id }}.html) | {{ item.name }} | {% if item.steps == "200" %} {{ item.steps }} {% else %} **{{ item.steps }}** {% endif %} | {{ item.equation }} | {{ item.w }} | {{ item.q_theta }} | {{ item.q_x }} | {{ item.note }} |
{% endfor %}
