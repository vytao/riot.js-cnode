<articlelist>
	<article each={data}></article>
	<script>
		var self = this;
		var api = 'https://cnodejs.org/api/v1/topics'
		riot.route('/',function() {
			update();
		})
		riot.route('topic...', function(){
			update(riot.route.query())
		})
		function update(query){
			var q = query || {tab:'all', page:1}
			$.getJSON(api, q, function(data){
				self.data = data.data
				self.trigger('update')
			})
		}
	</script>
	<style scoped>
		:scope{display: block;}
	</style>
</articlelist>

<article onclick = {click}>
	<h3 class="title {class}" title="{tabs}">{title}</h3>
	<div class="content">
		<img  class="avatar" src={author.avatar_url}>
		<div class="info">
			<p><span class="auther">{author.loginname}</span><span class="reply-count">{reply_count}</span><span class="split">/</span><span class="visit-count">{visit_count}</span></p>
			<p>	<span class="time">{Math.round((new Date() - new Date(this.create_at)) / 1000 / 60 / 60 / 24)}天前</span></p>
		</div>
	</div>
	
	<script>
		var self = this
		self.on('mount', function(){
			$(self.root).append(self.content)
		})
		click(e){
			$('.markdown-text', self.root).toggle();
		}
		if(this.top){
			this.tabs = '置顶'
			this.class = 'top'
		}else if(this.good){
			this.tabs = '精华'
			this.class = 'good'
		}else{
			switch(this.tab){
				case 'share':
					this.tabs = '分享'
				break
				case 'ask':
					this.tabs = '问答'
				break
				case 'job':
					this.tabs = '招聘'
				break
				default:
					this.tabs = '暂无'
					this.class = this.tab
			}		
		}
	</script>
	<style scoped>
		span{
			display: block;
		}
		.content{
			display: flex;
		}
		.info{
			width: 100%;
		}
		.info p{
			display: flex;
		}
		.auther{
			flex:1;
		}
		:scope{
			padding: 10px 15px;
			display: block;
			background: #fff;
			margin-bottom: .8rem;
		}
		h3{
			line-height: 1.5;
		}
		.title:before{
			content: attr(title);
			padding: 5px 6px;
			border-radius: 3px;
			font-size: 12px;
			margin-right: 10px;
			background: #e7e7e7;
		}
		.top:before{
			background:#e91e63;
		}
		.good:before{
			background: #8bc34a;
		}
		.share:before{
			background: #5bc0de;
		}
		.ask:before{
			background: #f89406;
		}
		.job:before{
			background: #607d8b;
		}
		.title{
			font-size: 14px;
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
		}
		.avatar{
			width: 36px;
			height: 36px;
			border-radius: 50%;
			margin-right: 10px;
		}
		.markdown-text{
			display: none;
		}
	</style>
</article>