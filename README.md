<div class="card-block">
<div class="row">
<div class="col tab-content">
<div class="tab-pane show active" id="subject" role="tabpanel">
<div class="row">
<div class="col-md-12 col-xl-12">
<div class="markdown-body">
<p class="text-muted m-b-15">
</p><h2>My Sqlite</h2>
<table>
<thead>
<tr>
<th>Technical details</th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<td>Submit files</td>
<td>my_sqlite_request. - my_sqlite_cli.</td>
</tr>
<tr>
<td>Languages</td>
<td>It needs to be completed in the language you are working on right now. If you are doing Bootcamp Javascript, then javascript (file extension will be .js). If you are doing Bootcamp Ruby, then Ruby (file extension will be .rb). It goes the same for Python, Java, C++, Rust, ...</td>
</tr>
</tbody>
</table>
<hr>
<p><strong>Part 00</strong>
Create a class called <code>MySqliteRequest</code> in <code>my_sqlite_request.rb</code>. It will have a similar behavior than a request on the real sqlite.</p>
<p>All methods, except <code>run</code>, will return an <code>instance</code> of <code>my_sqlite_request</code>. You will build the request by progressive call and execute the request by calling <code>run</code>.</p>
<p>Each row must have an ID.</p>
<p>We will do only <code>1</code> join and <code>1</code> where per request.</p>
<p><strong>Example00</strong>:</p>
<pre class=" language-plain"><code class=" language-plain">request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request = request.where('birth_state', 'Indiana')
request.run
=&gt; [{"name" =&gt; "Andre Brown"]
</code></pre>
<p><strong>Example01</strong>:</p>
<pre class=" language-plain"><code class=" language-plain">Input: MySqliteRequest.new('nba_player_data').select('name').where('birth_state', 'Indiana').run
Output: [{"name" =&gt; "Andre Brown"]
</code></pre>
<ol start="0">
<li>Constructor
It will be prototyped:</li>
</ol>
<p><code>def initialize</code></p>
<ol>
<li>From
Implement a <code>from</code> method which must be present on each request. From will take a parameter and it will be the name of the <code>table</code>. (technically a table_name is also a filename (.csv))</li>
</ol>
<p>It will be prototyped:</p>
<p><code>def from(table_name)</code></p>
<ol start="2">
<li>Select
Implement a <code>where</code> method which will take one argument a string OR an array of string. It will continue to build the request. During the run() you will collect on the result only the columns sent as parameters to select :-).</li>
</ol>
<p>It will be prototyped:</p>
<p><code>def select(column_name)</code>
OR
<code>def select([column_name_a, column_name_b])</code></p>
<ol start="3">
<li>Where
Implement a <code>where</code> method which will take 2 arguments: column_name and value.
It will continue to build the request. During the run() you will filter the result which match the value.</li>
</ol>
<p>It will be prototyped:</p>
<p><code>def where(column_name, criteria)</code></p>
<ol start="4">
<li>Join
Implement a <code>join</code> method which will load another filename_db and will join both database on a <code>on</code> column.</li>
</ol>
<p>It will be prototyped:</p>
<p><code>def join(column_on_db_a, filename_db_b, column_on_db_b)</code></p>
<ol start="5">
<li>Order
Implement an <code>order</code> method which will received two parameters, <code>order</code> (:asc or :description) and <code>column_name</code>. It will sort depending on the <code>order</code> base on the <code>column_name</code>.</li>
</ol>
<p>It will be prototyped:</p>
<p><code>def order(order, column_name)</code></p>
<ol start="6">
<li>Insert
Implement a method to <code>insert</code> which will receive <code>a table name</code> (filename). It will continue to build the request.</li>
</ol>
<p><code>def insert(table_name)</code></p>
<ol start="7">
<li>Values
Implement a method to <code>values</code> which will receive <code>data</code>. (a hash of data on format (<code>key</code> =&gt; <code>value</code>)).
It will continue to build the request. During the run() you do the insert.</li>
</ol>
<p><code>def values(data)</code></p>
<ol start="8">
<li>Update
Implement a method to <code>update</code> which will receive <code>a table name</code> (filename). It will continue to build the request.
An update request might be associated with a <code>where</code> request.</li>
</ol>
<p><code>def update(table_name)</code></p>
<ol start="8">
<li>Set
Implement a method to <code>update</code> which will receive <code>data</code> (a hash of data on format (<code>key</code> =&gt; <code>value</code>)).
It will perform the update of attributes on all <code>matching</code> row.
An update request might be associated with a <code>where</code> request.</li>
</ol>
<p><code>def set(data)</code></p>
<ol start="9">
<li>Delete
Implement a <code>delete</code> method. It set the request to delete on all <code>matching</code> row. It will continue to build the request.
An delete request might be associated with a <code>where</code> request.</li>
</ol>
<p><code>def delete</code></p>
<ol start="10">
<li>Run
Implement a <code>run</code> method and it will execute the request.</li>
</ol>
<p><strong>Part 01</strong>
Create a program which will be a Command Line Interface (CLI) to your <code>MySqlite</code> class.
It will use <code>readline</code> and we will run it with <code>ruby my_sqlite_cli.rb</code>.</p>
<p>It will accept request with:</p>
<ul>
<li>SELECT|INSERT|UPDATE|DELETE</li>
<li>FROM</li>
<li>WHERE (max 1 condition)</li>
<li>JOIN ON (max 1 condition)
Note, you can have multiple WHERE.
Yes, you should save and load the database from a file. :-)</li>
</ul>
<p>** Example 00 ** (Ruby)</p>
<pre class=" language-plain"><code class=" language-plain">$&gt;ruby my_sqlite_cli.rb class.db
MySQLite version 0.1 20XX-XX-XX
my_sqlite_cli&gt; SELECT * FROM students;
Jane|me@janedoe.com|A|http://blog.janedoe.com
my_sqlite_cli&gt;INSERT INTO students VALUES (John, john@johndoe.com, A, https://blog.johndoe.com);
my_sqlite_cli&gt;UPDATE students SET email = 'jane@janedoe.com', blog = 'https://blog.janedoe.com' WHERE name = 'Jane';
my_sqlite_cli&gt;DELETE FROM students WHERE name = 'John';
my_sqlite_cli&gt;quit
$&gt;
</code></pre>
<p>** Example 00 ** (Javascript)</p>
<pre class=" language-plain"><code class=" language-plain">$&gt;node my_sqlite_cli.js class.db
MySQLite version 0.1 20XX-XX-XX
my_sqlite_cli&gt; SELECT * FROM students;
Jane|me@janedoe.com|A|http://blog.janedoe.com
my_sqlite_cli&gt;INSERT INTO students VALUES (John, john@johndoe.com, A, https://blog.johndoe.com);
my_sqlite_cli&gt;UPDATE students SET email = 'jane@janedoe.com', blog = 'https://blog.janedoe.com' WHERE name = 'Jane';
my_sqlite_cli&gt;DELETE FROM students WHERE name = 'John';
my_sqlite_cli&gt;quit
$&gt;
</code></pre>
<p>Our examples will use these CSV
<a href="https://storage.googleapis.com/qwasar-public/nba_player_data.csv" target="_blank">Nba Player Data</a>
<a href="https://storage.googleapis.com/qwasar-public/nba_players.csv" target="_blank">Nba Players</a></p>
<p>In addition to accomplishing this challenge. You should take a read about those concepts:</p>
<ul>
<li>B-Tree (not binary tree "B-Tree")</li>
<li>TRIE</li>
<li>Reverse Index</li>
</ul>

<p></p>
</div>

</div>
</div>
</div>
<div class="tab-pane" id="solutions" role="tabpanel">
<div class="row">
<div class="col-xl-12">
<div aria-multiselectable="true" id="accordion" role="tablist">
<div class="accordion-panel">
<div class="accordion-heading" id="heading_76788" role="tab">
<h3 class="card-title accordion-title">
<a aria-controls="collapse_76788" aria-expanded="false" class="accordion-msg" data-parent="#accordion" data-toggle="collapse" href="#collapse_76788">
Iteration - 2
</a>
</h3>
</div>
<div aria-labelledby="heading_76788" class="panel-collapse collapse show" id="collapse_76788" role="tabpanel">
<div class="accordion-content accordion-desc">
<div class="row p-t-10">
<div class="col">
<div class="row">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Team
</h4>
</div>
</div>
<div class="row p-t-5">
<div class="col-6 col-sm-3 text-center">
<img class="img-radius w-30" src="https://storage.googleapis.com/qwasar-data-lake/users/anvarov_b/vrac/profile_picture_anvarov_b_5106_profile_picture_2021_11_15_15_19.jpg">
<div class="p-t-5">
<a href="/users/anvarov_b">anvarov_b</a>
</div>
</div>
<div class="col-6 col-sm-3 text-center">
<img class="img-radius w-30" src="https://storage.googleapis.com/qwasar-data-lake/users/mamirov_s/vrac/profile_picture_mamirov_s_5185_profile_picture_2021_11_16_05_04.jpeg">
<div class="p-t-5">
<a href="/users/mamirov_s">mamirov_s</a>
</div>
</div>
</div>
</div>
</div>

<div class="row m-b-10">
<div class="col-sm-9">
<hr>
<div class="row p-t-25">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Project Status: approved
</h4>
<div class="p-t-15">
Good job.
</div>

</div>
</div>
</div>
<div class="col-sm-3">
<div class="row align-items-end m-t-5">
<div class="col">
<a target="_blank" class="btn bg-c-dark-blue text-c-white hover-text-c-dark-blue hover-bg-c-white border-black radius-1 w-100" id="docode_button" href="https://api.docode.fi.qwasar.io/workspaces/rb7f8c653-db78"><i class="icofont icofont-code"></i>
Go to DoCode
</a></div>

</div>

</div>
</div>
<hr>
<div class="row p-t-10">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Information
</h4>
<pre class="text-pre-wrap bg-c-gray p-10 m-b-0 m-l-10 m-t-20">git@git.us.qwasar.io:my-sqlite_52733_zkr4ky/my-sqlite.git</pre>
<span class="font-italic p-b-10 f-10 m-l-10 p-l-10">
<span>
Download your ssh key from
</span>
<a class="f-10" href="/registrations/azimjan_bo/edit">your profile's settings
</a></span>
</div>
</div>

<hr>
<div class="row p-t-15">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Peer Review
</h4>
<div class="review-block p-t-0">
<div class="row m-t-20 align-items-center">
<div class="col-4 col-sm-2 text-center p-r-0">
<img class="img-radius w-50 m-t-15" src="https://storage.googleapis.com/qwasar-data-lake/users/juvin_g/vrac/profile_picture_juvin_g_192_profile_picture_2020_03_21_19_13.jpg">
</div>
<div class="col">
<div class="card" id="peer_review_17133">
<div class="card-header p-b-0">
<a href="/peer_reviews/17133"><h5 class="m-b-15 text-c-blue">
Peer Review  approved on  2022-07-01
</h5>
</a><p>
Reviewer: Gaetan JUVIN - juvin_g
Project members: Baxtibek ANVAROV - anvarov_b | Surobjon MAMIROV - mamirov_s
</p>
</div>
<div class="card-block text-normal-wrap">
<div class="row border-bottom border-c-dark-gray">
<div class="col-3 border-right border-c-dark-gray p-t-10">
Review Functionality
</div>
<div class="col p-l-15 p-b-15 p-r-15 p-t-10">
<div class="progress medium b-radius-1 text-c-white font-weight-bold" data-toggle="tooltip" title="" data-original-title="11 / 11">
<div class="progress-bar bg-c-green-90" style="width: 100.0%"></div>
</div>
</div>
</div>
<div class="row border-bottom border-c-dark-gray">
<div class="col-3 border-right border-c-dark-gray">
Code Quality
</div>
<div class="col-8 p-10">
<p>Bad usage of git:</p>
<p>your git commit are:
Baxtibek anvarov
MySQLITE
June 10, 2022 7:09am
Baxtibek anvarov
MySqlite
June 10, 2022 6:59am
Baxtibek anvarov
MySqlite
June 10, 2022 1:43am
Baxtibek anvarov
Mysqlite</p>
<p>Only one of you has worked on the project??</p>
<p>Code is mostly clean. Good usage of Ruby</p>

</div>
</div>
<div class="row">
<div class="col-3 border-right border-c-dark-gray">
Review
</div>
<div class="col p-10">
<p>Good my sqlite.</p>
<p>You will have to improve your usage of GIT. You cannot just use "mysqlite" as a message to describe your commit.</p>
<p>Did Surobjon Mamirov work on the project?</p>

</div>
</div>
</div>

</div>
</div>
</div>

</div>
</div>
</div>



</div>
</div>
</div>
</div>
<div aria-multiselectable="true" id="accordion" role="tablist">
<div class="accordion-panel">
<div class="accordion-heading" id="heading_76115" role="tab">
<h3 class="card-title accordion-title">
<a aria-controls="collapse_76115" aria-expanded="false" class="accordion-msg" data-parent="#accordion" data-toggle="collapse" href="#collapse_76115">
Iteration - 1
</a>
</h3>
</div>
<div aria-labelledby="heading_76115" class="panel-collapse collapse" id="collapse_76115" role="tabpanel">
<div class="accordion-content accordion-desc">
<div class="row p-t-10">
<div class="col">
<div class="row">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Team
</h4>
</div>
</div>
<div class="row p-t-5">
<div class="col-6 col-sm-3 text-center">
<img class="img-radius w-30" src="https://storage.googleapis.com/qwasar-data-lake/users/anvarov_b/vrac/profile_picture_anvarov_b_5106_profile_picture_2021_11_15_15_19.jpg">
<div class="p-t-5">
<a href="/users/anvarov_b">anvarov_b</a>
</div>
</div>
<div class="col-6 col-sm-3 text-center">
<img class="img-radius w-30" src="https://storage.googleapis.com/qwasar-data-lake/users/mamirov_s/vrac/profile_picture_mamirov_s_5185_profile_picture_2021_11_16_05_04.jpeg">
<div class="p-t-5">
<a href="/users/mamirov_s">mamirov_s</a>
</div>
</div>
</div>
</div>
</div>

<div class="row m-b-10">
<div class="col-sm-9">
<hr>
<div class="row p-t-25">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Project Status: rejected
</h4>
<div class="font-italic p-t-15">
"If you are not willing to learn, no one can help you. If you are determined to learn, no one can stop you." -- Zig Ziglar
</div>
<div class="p-t-10">
It's time to grow and have a strong mind:
</div>
<ul class="p-t-5">
<li>
Acknowledge your mistakes
</li>
<li>
Ask yourself the hard questions
</li>
<li>
Create a plan
</li>
<li>
Reopen your solution and improve it! :)
</li>
</ul>

</div>
</div>
</div>
<div class="col-sm-3">
<div class="row align-items-end m-t-5">
<div class="col">
<a target="_blank" class="btn bg-c-dark-blue text-c-white hover-text-c-dark-blue hover-bg-c-white border-black radius-1 w-100" id="docode_button" href="https://api.docode.fi.qwasar.io/workspaces/rb7f8c653-db78"><i class="icofont icofont-code"></i>
Go to DoCode
</a></div>

</div>

</div>
</div>
<hr>
<div class="row p-t-10">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Information
</h4>
<pre class="text-pre-wrap bg-c-gray p-10 m-b-0 m-l-10 m-t-20">git@git.us.qwasar.io:my-sqlite_52733_zkr4ky/my-sqlite.git</pre>
<span class="font-italic p-b-10 f-10 m-l-10 p-l-10">
<span>
Download your ssh key from
</span>
<a class="f-10" href="/registrations/azimjan_bo/edit">your profile's settings
</a></span>
</div>
</div>

<hr>
<div class="row p-t-15">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Peer Review
</h4>
<div class="review-block p-t-0">
<div class="row m-t-20 align-items-center">
<div class="col-4 col-sm-2 text-center p-r-0">
<img class="img-radius w-50 m-t-15" src="https://storage.googleapis.com/qwasar-data-lake/users/juvin_g/vrac/profile_picture_juvin_g_192_profile_picture_2020_03_21_19_13.jpg">
</div>
<div class="col">
<div class="card" id="peer_review_16817">
<div class="card-header p-b-0">
<a href="/peer_reviews/16817"><h5 class="m-b-15 text-c-blue">
Peer Review  rejected on  2022-06-16
</h5>
</a><p>
Reviewer: Gaetan JUVIN - juvin_g
Project members: Baxtibek ANVAROV - anvarov_b | Surobjon MAMIROV - mamirov_s
</p>
</div>
<div class="card-block text-normal-wrap">
<div class="row border-bottom border-c-dark-gray">
<div class="col-3 border-right border-c-dark-gray p-t-10">
Review Functionality
</div>
<div class="col p-l-15 p-b-15 p-r-15 p-t-10">
<div class="progress medium b-radius-1 text-c-white font-weight-bold" data-toggle="tooltip" title="" data-original-title="11 / 11">
<div class="progress-bar bg-c-green-90" style="width: 100.0%"></div>
</div>
</div>
</div>
<div class="row border-bottom border-c-dark-gray">
<div class="col-3 border-right border-c-dark-gray">
Code Quality
</div>
<div class="col-8 p-10">
<p>(REJECT) run! is too long</p>

</div>
</div>
<div class="row">
<div class="col-3 border-right border-c-dark-gray">
Review
</div>
<div class="col p-10">
<p>All features are implemented, good job.</p>
<p>But your code quality needs to be improved. Refactor/improve your CLI part.
You should read about the REPL design pattern.</p>
<p>Good luck with your next iteration!</p>

</div>
</div>
</div>

</div>
</div>
</div>

</div>
</div>
</div>



</div>
</div>
</div>
</div>
<div aria-multiselectable="true" id="accordion" role="tablist">
<div class="accordion-panel">
<div class="accordion-heading" id="heading_74530" role="tab">
<h3 class="card-title accordion-title">
<a aria-controls="collapse_74530" aria-expanded="false" class="accordion-msg" data-parent="#accordion" data-toggle="collapse" href="#collapse_74530">
Iteration - 0
</a>
</h3>
</div>
<div aria-labelledby="heading_74530" class="panel-collapse collapse" id="collapse_74530" role="tabpanel">
<div class="accordion-content accordion-desc">
<div class="row p-t-10">
<div class="col">
<div class="row">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Team
</h4>
</div>
</div>
<div class="row p-t-5">
<div class="col-6 col-sm-3 text-center">
<img class="img-radius w-30" src="https://storage.googleapis.com/qwasar-data-lake/users/anvarov_b/vrac/profile_picture_anvarov_b_5106_profile_picture_2021_11_15_15_19.jpg">
<div class="p-t-5">
<a href="/users/anvarov_b">anvarov_b</a>
</div>
</div>
<div class="col-6 col-sm-3 text-center">
<img class="img-radius w-30" src="https://storage.googleapis.com/qwasar-data-lake/users/mamirov_s/vrac/profile_picture_mamirov_s_5185_profile_picture_2021_11_16_05_04.jpeg">
<div class="p-t-5">
<a href="/users/mamirov_s">mamirov_s</a>
</div>
</div>
</div>
</div>
</div>

<div class="row m-b-10">
<div class="col-sm-9">
<hr>
<div class="row p-t-25">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Project Status: rejected
</h4>
<div class="font-italic p-t-15">
"If you are not willing to learn, no one can help you. If you are determined to learn, no one can stop you." -- Zig Ziglar
</div>
<div class="p-t-10">
It's time to grow and have a strong mind:
</div>
<ul class="p-t-5">
<li>
Acknowledge your mistakes
</li>
<li>
Ask yourself the hard questions
</li>
<li>
Create a plan
</li>
<li>
Reopen your solution and improve it! :)
</li>
</ul>

</div>
</div>
</div>
<div class="col-sm-3">
<div class="row align-items-end m-t-5">
<div class="col">
<a target="_blank" class="btn bg-c-dark-blue text-c-white hover-text-c-dark-blue hover-bg-c-white border-black radius-1 w-100" id="docode_button" href="https://api.docode.fi.qwasar.io/workspaces/rb7f8c653-db78"><i class="icofont icofont-code"></i>
Go to DoCode
</a></div>

</div>

</div>
</div>
<hr>
<div class="row p-t-10">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Information
</h4>
<pre class="text-pre-wrap bg-c-gray p-10 m-b-0 m-l-10 m-t-20">git@git.us.qwasar.io:my-sqlite_52733_zkr4ky/my-sqlite.git</pre>
<span class="font-italic p-b-10 f-10 m-l-10 p-l-10">
<span>
Download your ssh key from
</span>
<a class="f-10" href="/registrations/azimjan_bo/edit">your profile's settings
</a></span>
</div>
</div>

<hr>
<div class="row p-t-15">
<div class="col">
<h4 class="text-uppercase text-c-blue">
Peer Review
</h4>
<div class="review-block p-t-0">
<div class="row m-t-20 align-items-center">
<div class="col-4 col-sm-2 text-center p-r-0">
<img class="img-radius w-50 m-t-15" src="https://storage.googleapis.com/qwasar-data-lake/users/thompson_b/vrac/profile_picture_thompson_b_4379_profile_picture_2021_09_21_16_39.jpg">
</div>
<div class="col">
<div class="card" id="peer_review_16613">
<div class="card-header p-b-0">
<a href="/peer_reviews/16613"><h5 class="m-b-15 text-c-blue">
Peer Review  rejected on  2022-06-06
</h5>
</a><p>
Reviewer: Brian THOMPSON - thompson_b
Project members: Baxtibek ANVAROV - anvarov_b | Surobjon MAMIROV - mamirov_s
</p>
</div>
<div class="card-block text-normal-wrap">
<div class="row border-bottom border-c-dark-gray">
<div class="col-3 border-right border-c-dark-gray p-t-10">
Review Functionality
</div>
<div class="col p-l-15 p-b-15 p-r-15 p-t-10">
<div class="progress medium b-radius-1 text-c-white font-weight-bold" data-toggle="tooltip" title="" data-original-title="5 / 11">
<div class="progress-bar bg-c-orange-90" style="width: 45.45454545454545%"></div>
</div>
</div>
</div>
<div class="row border-bottom border-c-dark-gray">
<div class="col-3 border-right border-c-dark-gray">
Code Quality
</div>
<div class="col-8 p-10">
<p>Comment can't quite fit here, check out the peer review section for feedback.</p>

</div>
</div>
<div class="row">
<div class="col-3 border-right border-c-dark-gray">
Review
</div>
<div class="col p-10">
<p>Hello, great job on the project so far. A few things I had trouble with:</p>
<p>Upon running  select query from my_sqlite_request.rb the request returns no results. I realize that you have it set up to display results if you p request.run however that is not in the grading rubric and should be handled within the request itself. The command should display the results without having to p request.run. If however you chose not to handle the request within the select, you ought to explain how to properly run your query in your README. Instructions for how to run order and join methods ought to be explained there as well.</p>
<p>Additionally for the select query :</p>
<p>request = MySqliteRequest.new<br>
request = request.from('nba_player_data.csv')<br>
request = request.select('name')<br>
request = request.where('college', 'University of California')<br>
request = request.where('year_start', '1997')<br>
request.run</p>
<p>Running this command with the request.run replaced with p request.run returns players who had a college of University of California OR had a year start of 1997. It should be AND. The request should only return one player who has both had a college of University of California AND had a year start of 1997.</p>
<p>For the update request:
request = MySqliteRequest.new
request = request.update('nba_player_data.csv')
request = request.set('name' =&gt; 'Alaa Renamed')
request = request.where('name', 'Alaa Abdelnaby')
request.run</p>
<p>The update only updates a single row. If there are multiple instances of players named 'Alaa Abdelnaby', only one will be updated while the rest remain the same. The delete request removes them all and the update request should behave similarly.</p>
<p>I could not get your order method to execute and it doesn't look like you implemented the join method. Though it is not in the Review Functionality section of the peer review it is a part of the project and ought to be implemented.</p>
<p>My_sqlite_cli:</p>
<p>The review questions on the peer review are for a csv that isn't provided in the project details... why I do not know, so I mirrored the requests but using the nba_player_data.csv file and the headers associated with said file, ill list the commands I ran and whether they worked or not.</p>
<p>Generally I think you should use a token to replace 'nba_player_data.csv'. Like 'players' or something like that. This more closely resembles sqlite functionlity, but that’s personal preference.</p>
<p>Question 6 - SELECT * FROM nba_player_data.csv
The above worked great</p>
<p>Question 7 - SELECT name, college FROM nba_player_data.csv where college = Duke University
I was unable to get the multiple select column statement above to work</p>
<p>Question 8 - INSERT INTO nba_player_data_light.csv VALUES (Don Adams, 1971, 1977, F,6-6,210,"November 27 1947",Northwestern University)
This command worked however it inserted the player information into the file without spaces, this should be updated.</p>
<p>Question 9 - UPDATE nba_player_data_light.csv SET weight = 0, height = 0 WHERE name = Alaa Abdelnaby
This multiple set command did not work. Singular works but the review functionality calls for multiple set updates.</p>
<p>Question 10 - DELETE FROM nba_player_data_light.csv WHERE name = Alaa Abdelnaby
This command worked.</p>
<p>Overall you two have most of the project down. You just need to make some tweaks here and there to get the above statements, questions to work. After implementing the join and order methods I would provide instructions on how to execute them in the README, or provide test cases that the user can run for these and the above commands. Great job so far! Excited to see the finished product.</p>

</div>
</div>
</div>

</div>
</div>
</div>

</div>
</div>
</div>



</div>
</div>
</div>
</div>

</div>
</div>
</div>
<div class="tab-pane" id="resources" role="tabpanel">
<div class="row">
<div class="col-xl-12">
<div class="row text-center">
<div class="col p-t-10 f-12">
<p>
Mysql Overview
</p>
</div>
</div>
<div class="row text-center">
<div class="col">
<iframe frameborder="0" src="https://www.youtube.com/embed/TPsEhjD0yR8"></iframe>
</div>
</div>
<hr>
<div class="row text-center">
<div class="col">
<a target="_blank" href="https://drive.google.com/file/d/12OoYyCfYqtXw66eqUBoBD-T_se89NjzW/view?usp=drive_link">SWE Testing Education</a>
</div>
</div>

</div>
</div>
</div>
</div>
</div>
</div>
