# README

## Development

```
npm install -g coin-hive-stratum
coin-hive-stratum 8892 --host=la01.supportxmr.com --port=3333
```


<!--
Notes

<p>The hashes you generate will be disbursed to projects using Give a Hash, ultimately paying out as Monero to those projects.</p>

Users are already project by sparing a few of their CPU cycles and you will get paid in <a href="https://www.monero.how/monero-ELI5">Monero</a> of your software can start donating to your project simplly by contributing 


<p>How? Users give back to open source by contributing a handful of CPU cycles. They donate their CPU cycles &amp; you get paid in <a href="https://www.monero.how/monero-ELI5">Monero</a>.</p>

<p>You have open source projects that people use. GiveAHash.org makes it possible for those people to donate to your project by simply donating some of their CPU power. They donate their CPU cycles &amp; you get paid in <a href="https://www.monero.how/monero-ELI5">Monero</a>.</p>

<p>
  <a href="">Add your project</a>, <a href="">How it works</a>
</p>

<h2 class="text-center">
  Donate to open source
</h2>

<p class="text-center">
  Donate to open source software by mining cryptocurrency.
</p>

<p class="text-center">
  Give it a try! Click 'Start Mining' above, if you haven't already.
</p>
<p class="text-center">
  The hashes you generate will be disbursed to open source projects around the world.
</p>

<br/>
<br/>
<br/>
<br/>

-->


<h2 class="text-center">Earn money for your open source projects.</h2>
<p class="text-center">Give a Hash lets others donate some of their cpu cycles to your open source project. They donate their cycles & you get paid in Monero.</p>

<p class="text-center">Have your own open source project? Add it below to start getting paid.</p>

<div class="text-center">
  <%= form_for NewProject.new, url: project_path, method: :post do |f| -%>
    <%= f.text_field :url, required: true, placeholder: "Enter your project url" %>
    <%= f.submit "Get Started", class: "button-primary" %>
  <% end -%>
</div>


<!--
<h2>Earn some money on your open source projects</h2>

<h3>Give a Hash lets your users donate some of their cpu cycles to your open source project. They donate their cycles & you get paid in Monero.</h3>
-->


