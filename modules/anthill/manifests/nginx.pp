#
# NGINX reverce proxy and web resources
#
# @option editor icon data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2aWV3Qm94PSIwIDAgMTE1LjExODc1IDI0LjE4NzI3NSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTExLjU2MjI1IC0xMS4xMjQyMikiPjxwYXRoIGlkPSJhIiBkPSJtMTQuMDQ3ODM4IDMyLjcyNzU5MnYtMTkuMDY0Njk1bDE5LjA2MjQ5OSAxOS4wNjQ2OTV2LTE5LjA2NDY5NSIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDkwIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iNSIvPjxwYXRoIGQ9Im00NC42ODc1IDExLjE4NzUtLjY4NzUgMS4yODEyNS01LjMxMjUgOS42NTYyNS0uNjg3NSAxLjIxODc1LjY4NzUgMS4yMTg3NSA1LjMxMjUgOS4zNDM3NS43MTg3NSAxLjI4MTI1aDEuNDY4NzUgMTAuODc1IDEuNTYyNWwuNjg3NS0xLjQwNjI1IDMuOTY4NzUtOCAxLjc4MTI1LTMuNjI1aC00LjAzMTI1bC0xMC4xNTYyNS4wMzEyNWMtMS4zMjA3ODItLjAxODY4LTIuNTM1NjA1IDEuMTc5MDg2LTIuNTM1NjA1IDIuNXMxLjIxNDgyMyAyLjUxODY3OSAyLjUzNTYwNSAyLjVsNi4xMjUtLjAzMTI1LTEuNSAzLjAzMTI1aC03Ljg3NWwtMy45MDYyNS02Ljg3NSAzLjkzNzUtNy4xMjVoOC4zNzcyMjFsMS45NTMxMjUgNC4wMDc4MTJoNS4wMzEyNWwtMy4xNzE4NzUtNy42MDE1NjItLjY4NzUtMS40MDYyNWgtMS41NjI1LTExLjQwODQ3MXoiIGZpbGw9IiMwOTAiLz48cGF0aCBkPSJtNzAuMDEzNzgyIDExLjE1NjI1Yy0xLjMwODk4OS4wMTYzOS0yLjQ4NTA4NCAxLjIyMjI2MS0yLjQ2ODc1IDIuNTMxMjV2Ni41MTQ1MDloNXYtNi41MTQ1MDljLjAxNjU5LTEuMzI5ODIxLTEuMjAxNDI5LTIuNTQ3ODQzLTIuNTMxMjUtMi41MzEyNXoiIGZpbGw9IiMwOTAiLz48dXNlIGhlaWdodD0iMTA1Mi4zNjIyIiB0cmFuc2Zvcm09Im1hdHJpeCgtMSAwIDAgMSAxMTEuMTM5MDUgLjA0ODQxNjIzKSIgd2lkdGg9Ijc0NC4wOTQ0OCIgeGxpbms6aHJlZj0iI2EiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSguMTA1ODYyNTEgLjMzMDEwMjI4KSI+PHBhdGggaWQ9ImIiIGQ9Im0xMDQuOTA5MzUgMTMuMzc0MjA5IDE5LjA4NDgxIDE5LjAxNzg1NiIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDkwIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iNSIvPjx1c2UgaGVpZ2h0PSIxMDUyLjM2MjIiIHRyYW5zZm9ybT0ibWF0cml4KC0xIDAgMCAxIDIyOC45MjU4MyAwKSIgd2lkdGg9Ijc0NC4wOTQ0OCIgeGxpbms6aHJlZj0iI2IiLz48L2c+PHBhdGggZD0ibTcwLjAxMzc4MiAzNS4yMDQwNjljLTEuMzA4OTg5LS4wMTYzOS0yLjQ4NTA4NC0xLjIyMjI2MS0yLjQ2ODc1LTIuNTMxMjV2LTEwLjQ2NDM2M2g1djEwLjQ2NDM2M2MuMDE2NTkgMS4zMjk4MjEtMS4yMDE0MjkgMi41NDc4NDMtMi41MzEyNSAyLjUzMTI1eiIgZmlsbD0iIzA5MCIvPjwvZz48L3N2Zz4=
#
class anthill::nginx (

  Integer $listen_port = $anthill::nginx::params::listen_port,
  String $user = $anthill::nginx::params::user,

  Boolean $ssl = $anthill::nginx::params::ssl,
  String $ssl_cert = $anthill::nginx::params::ssl_cert,
  String $ssl_key = $anthill::nginx::params::ssl_key,
  Integer $ssl_port = $anthill::nginx::params::ssl_port

) inherits anthill::nginx::params {

  anchor { 'anthill::nginx::begin': } ->

  class { '::anthill::nginx::install': } ->

  anchor { 'anthill::nginx::end': }
}