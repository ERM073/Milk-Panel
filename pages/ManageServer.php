<?php include 'header.php'; ?>
<div class="container-fluid">
	<!-- DataTales Example -->
	<div class="col">
		<div class="card shadow mb-4">
			<!-- Card Header - Dropdown -->
			<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
				<h6 class="m-0 font-weight-bold text-primary">サーバー詳細</h6>
			</div>
			<div class="card-body">
				<section id="list">
					<table class="table table-striped" id="dataTable">
						<thead class="bg-primary text-light">
							<th>ID </th>
							<th>ドメイン </th>
							<th>PHPバージョン</th>
							<th>ステータス</th>
							<th>ディレクトリ</th>
						</thead>
						<tbody>
							<td>1</td>
							<td>Default::root </td>
							<td>7.4 stable</td>
							<td>active</td>
							<td>/var/www/html/</td>
						</tbody>
					</table>
				</section>
			</div>
		</div>
		<div class="card shadow mb-4">
			<!-- Card Header - Dropdown -->
			<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
				<h6 class="m-0 font-weight-bold text-primary">再起動</h6>
			</div>
			<div class="card-body">
				<section id="list">
					<table class="table table-striped" id="dataTable">
						<thead class="bg-primary text-light">
							<tr>
								<th>ID </th>
								<th>サービス名 </th>
								<th>再起動</th>
								<th>Start/Stop</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>Apache2 </td>
								<td><button type="button" class="btn btn-outline-warning">今すぐ再起動</td>
								<td><button type="button" class="btn btn-outline-danger">Stop</td>
							</tr>
							<tr>
								<td>2</td>
								<td>MySQL </td>
								<td><button type="button" class="btn btn-outline-warning">今すぐ再起動</td>
								<td><button type="button" class="btn btn-outline-danger">Stop</td>
							</tr>
							<tr>
								<td>3</td>
								<td>ProFTPD </td>
								<td><button type="button" class="btn btn-outline-warning">今すぐ再起動</td>
								<td><button type="button" class="btn btn-outline-danger">Stop</td>
							</tr>
						</tbody>
					</table>
				</section>
			</div>
		</div>
	</div>
</div>
<?php include 'footer.php'; ?>