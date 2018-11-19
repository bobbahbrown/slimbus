{% extends "base/index.html"%}
{%block content %}
{% if user.ckey %}

<div class="page-header">
  {% if statbus.auth.remote_auth %}
  <a class="badge badge-danger float-right" href="{{path_for('logout')}}">Logout</a>
  {% endif %}
  <h1><small class="text-muted">You are</small> {{user.label|raw}}</h1>
</div>
<hr>

<p class="lead">
Between your first connection {{user.firstseen|timestamp}} and your most recent connection {{user.lastseen|timestamp}}, you have connected {{user.connections}} times.
</p>

<p class="lead">You have wasted <span title="About {{user.hours}}, since we started tracking time spent in roles" data-toggle="tooltip">0</span> hours playing Space Station 13, because time spent doing something you enjoy isn't wasted time.</p>

<div class="card">
  <h3 class="card-header">Role Time</h3>
  <div class="card-body">
    <div id="roletime">

    </div>
    <p>(Tracked over time since around July of 2017)</p>
  </div>
</div>

{% else %}
<div class="page-header">
  <h1>Hmm...</h1>
</div>
<hr>
  <p class="lead">I'm not sure who you are. Can you please authenticate with the remote website for me?</p>
  <a href="{{path_for('auth')}}" class="btn btn-success btn-lg btn-block">Authenticate</a>
{% endif %}

{% endblock %}

{% block js %}
<script type="text/javascript" src="https://cdn.plot.ly/plotly-latest.min.js"></script>

<script>
var data = {{roleData|raw}};
var jobs = unpack(data,'job');
var minutes = unpack(data,'minutes');
var trace1 = {
  x: jobs,
  y: minutes,
  type: 'bar',
  name: 'Minutes'
}

var data = [trace1]
Plotly.newPlot('roletime',data)
</script>
{% endblock %}