<h1><i class="fa fa-envelope-o"></i> 邮件服务 (Local)</h1>

<div class="row">
	<div class="col-lg-12">
		<blockquote>
			这个插件可以让NodeBB通过SMTP接口发送电子邮件.
		</blockquote>
	</div>
</div>

<hr />

<form role="form" class="emailer-local-settings">
	<fieldset>
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<label for="emailer:local:host">域名地址 host</label>
					<input type="text" class="form-control" id="emailer:local:host" name="emailer:local:host" />
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<label for="emailer:local:port">端口号</label>
					<input type="text" class="form-control" value="25" id="emailer:local:port" name="emailer:local:port" />
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<label for="emailer:local:username">用户</label>
					<input type="text" class="form-control" id="emailer:local:username" name="emailer:local:username" />
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<label for="emailer:local:password">密码</label>
					<input type="password" class="form-control" id="emailer:local:password" name="emailer:local:password" />
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<label>
						<input type="checkbox" id="emailer:local:secure" name="emailer:local:secure"/>
						 启用安全连接
					</label>
				</div>
			</div>
		</div>

		<button class="btn btn-lg btn-primary" id="save">保存</button>
	</fieldset>
</form>

<script type="text/javascript">
	require(['settings'], function(Settings) {
		Settings.load('emailer-local', $('.emailer-local-settings'));

		$('#save').on('click', function() {
			Settings.save('emailer-local', $('.emailer-local-settings'), function() {
				app.alert({
					alert_id: 'emailer-local',
					type: 'info',
					title: '设置更改',
					message: '请重新加载应用这些更改',
					timeout: 5000,
					clickfn: function() {
						socket.emit('admin.reload');
					}
				});
			});
		});
	});
</script>
