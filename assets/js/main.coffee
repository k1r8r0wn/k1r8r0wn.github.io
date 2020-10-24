---
---

# Data
xAxisData = [
  { categories: ['Ruby (2 & newer)', 'Elixir', 'Sinatra', 'Hanami', 'Ruby on Rails (3 & newer)' , 'Phoenix'] }
  { categories: ['HTML', 'CSS', 'Bootstrap/Foundation', 'JavaScript(ES5)', 'Vue.js'] }
  { categories: ['RSpec', 'Capybara', 'Cucumber'] }
  { categories: ['MySQL', 'PostgreSQL'] }
  { categories: ['macOS', 'Linux', 'Windows'] }
  { categories: ['Bash', 'Git', 'Docker', 'CI/CD'] }
  { categories: ['Russian', 'English', 'French'] }
]

seriesData = [
  {
    name: 'Back end'
    color: 'rgb(220,50,47)'
    data: [7, 1, 4, 2, 7, 1]
  }
  {
    name: 'Front end'
    color: 'rgb(181,137,0)'
    data: [8, 7, 7, 4, 2]
    visible: false
    xAxis: 1
  }
  {
    name: 'TDD'
    color: 'rgb(108,113,196)'
    data: [5, 4, 3]
    visible: false
    xAxis: 2
  }
  {
    name: 'Databases'
    color: 'rgb(203,75,22)'
    data: [4, 4]
    visible: false
    xAxis: 3
  }
  {
    name: 'OS'
    color: 'rgb(38,139,210)'
    data: [9, 6, 4]
    visible: false
    xAxis: 4
  }
  {
    name: 'Dev tools'
    color: 'rgb(147,161,161)'
    data: [7, 8, 5, 4]
    visible: false
    xAxis: 5
  }
  {
    name: 'Languages'
    color: 'rgb(133,153,0)'
    data: [9, 6, 1]
    visible: false
    xAxis: 6
  }
]

# Navigation
$hamburgerIcon = $('.hamburger-icon').unbind()
$navMenu = $('.navigation-menu')

$navMenu.removeClass 'show'
$hamburgerIcon.on 'click', (e) ->
  e.preventDefault()
  $(this).toggleClass 'open'
  $navMenu.slideToggle ->
    if $navMenu.is(':hidden')
      $navMenu.removeAttr 'style'

# Smooth scroll to tag
$('.tag').on 'click', ->
  $id = $(this).attr('href')
  $('html, body').animate({ scrollTop: $($id).offset().top }, 1000)

# Skills chart
$chart = $('#chart')

if $chart.length > 0
  chart = undefined
  chart = new (Highcharts.Chart)({
    chart: {
      polar: true
      type: 'area'
      backgroundColor: null
      style: {
        fontFamily: 'Fira Mono'
      }
      renderTo: 'chart'
    }
    title: { text: 'My skillset chart (just subjective perspective)' }
    pane: { size: '80%' }
    xAxis: xAxisData
    yAxis: {
      labels: {
        enabled: false
      }
    }
    tooltip: {
      pointFormat: '<span>{series.name}: <b>{point.y:,.0f}/10</b><br/>'
    }
    legend: {
      verticalAlign: 'bottom'
      itemMarginBottom: 15
      layout: 'horizontal'
    }
    credits: {
      enabled: false
    }
    series: seriesData
    plotOptions: {
      series: {
        fillOpacity: .5
        events: {
          show: ->
            chart = @chart
            series = chart.series
            i = series.length
            otherSeries = undefined
            while i--
              otherSeries = series[i]
              if otherSeries != this and otherSeries.visible
                otherSeries.hide()
          legendItemClick: ->
            if @visible
              return false
        }
      }
    }
  })
