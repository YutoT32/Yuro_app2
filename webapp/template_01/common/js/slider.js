//A-yo. ;)

(function(){

	// options
	var options = {
		duration: 400,
		easing: 'easeOutCubic',
		auto: true,
		interval: 4000
	};

	// doms
	var $window = $(window),
		$container = $('#slider'),
		$element = $container.find('ul'),
		$list = $element.find('li'),
		$next = $container.find('#next'),
		$prev = $container.find('#prev'),
		shift = 2,
		lw = $list.width(),
		len = $list.length,
		timer = '';

	var $header = $('#header'),
		$headerAfter = $header.next(),
		headerY = $header.height(),
		containerY = $container.height();

	function initialize(){
		setup();
		$window.on('resize', resize);
		$next.on('click', function(){ slide(true); });
		$prev.on('click', function(){ slide(false); });
		$window.on('scroll', scroll);
		load();
		if(options.auto) timer = setInterval(function(){ slide(true) }, options.interval);
	};

	function setup(){

		for(var i = shift; i > 0; i--) $element.find('li').eq(len - i).remove().prependTo($element);

		// div.layerを2つ追加する。
		for(var i = 0; i < 2; i++) $('<div class="layer"></div>').insertAfter($element);

		// 上で追加したdivを変数に入れる
		$leftlayer = $container.find('.layer').eq(0);
		$rightlayer = $container.find('.layer').eq(1);

		// resize関数を呼ぶ
		resize();

	};

	function resize(){
		var _val = ($window.width() - lw) / 2 - lw * shift;
		$element.css({
			'width': lw * len,
			'left': _val
		});
		$leftlayer.css('left', _val + lw);
		$rightlayer.css('left', _val + lw * 3);
	};

	// アニメーションを管理する関数
	function slide(direction){

		// $elementがアニメーション中なら、処理しない
		if($element.filter(':animated').length) return;

		// ループを停止
		if(options.auto) clearInterval(timer);

		// 移動を変数に入れる。引数がtrueなら-lw,falseならlw
		val = (direction)? -lw: lw;

		// アニメーションスタート。最後にコールバック関数を呼び出す。
		$element.animate({
			'marginLeft': val
		}, options.duration, options.easing, callback);

	};

	// slide関数実行後に呼び出す関数
	function callback(){

		// valが0より小さければ、最初のliを最後に移動させる。　
		// valが0より大きければ、最後のliを最初に移動させる。
		(0 > val)? $element.find('li').eq(0).remove().appendTo($element): $element.find('li').eq(len - 1).remove().prependTo($element);

		// valが0より大きければ、最後のliを最初に移動させる。
		$element.css('marginLeft', 0);

		// options.autoがtrueなら、ループを開始
		if(options.auto) timer = setInterval(function(){ slide(true) }, options.interval);

	};


	// ヘッダーを固定する関数
	function scroll(){

		// スクロール量がcontainerYを上回ったら、関数_fixedを実行
		// スクロール量がcontainerYを上回ったら、関数_staticを実行
		(containerY <= $window.scrollTop())?
			_fixed() :
			_static();

		function _fixed(){
			$header.css({
				'position': 'fixed',
				'top': 0,
				'left': 0
			});
			$headerAfter.css('marginTop', headerY);
		};

		function _static(){
			$header.css({
				'position': 'static',
				'top': '',
				'left': ''
			});
			$headerAfter.css('marginTop', '');
		};

	};

	function load(){
		var array = [$element, $next, $prev];
		for(var i = 0; i < array.length; i++) array[i].css('visibility', 'visible');
		$container.css('background', 'none');
	};

	$window.on('load', initialize);
	
}());