var onYouTubeIframeAPIReady = null;

function YouTube(player, options) {
    var PLAYER_WIDTH = 480;
    var PLAYER_HEIGHT = 272;

    this.defaultOptions = {
        stopAfter: 3,
        waitFor: 7.3,
        onStop: null,
        onContinue: null
    };
    this.options = {};
    this.wasStopped = false;

    this.init = function() {
        this.$player = player;
        this.protectVideo();
        $.extend(this.options, this.defaultOptions, options);
        var self = this;
        onYouTubeIframeAPIReady = function() {
            self.player = new YT.Player(player[0], {
                width: PLAYER_WIDTH,
                height: PLAYER_HEIGHT,
                playerVars: {
                    controls: 0,
                    showinfo: 0,
                    disablekb: 1,
                    autoplay: 1,
                    rel: 0
                },
                videoId: self.$player.data('code'),
                events: {
                    onStateChange: self.onPlayerStateChange.bind(self)
                }
            });
        };
        this.addYouTubeApi();
    };

    this.addYouTubeApi = function() {
        var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    };

    this.protectVideo = function() {
        $('<div>')
            .css({
                position: 'relative'
            })
            .insertAfter(this.$player)
            .append(this.$player)
            .append(
                $('<div>')
                    .css({
                        position: 'absolute',
                        width: '100%',
                        height: PLAYER_HEIGHT,
                        top: 0,
                        left: 0
                    })
            );
    };

    this.onPlayerStateChange = function(evt) {
        if (evt.data == YT.PlayerState.PLAYING && !this.wasStopped) {
            setTimeout(this.stopVideo.bind(this), this.options.stopAfter * 1000);
        }


        if (evt.data == YT.PlayerState.PAUSED && !this.wasStopped) {
            this.wasStopped = true;
            setTimeout(this.startVideo.bind(this), this.options.waitFor * 1000);
        }
    };

    this.stopVideo = function() {
        var delta = this.options.stopAfter - this.player.getCurrentTime();
        if (delta > 0) {
            setTimeout(this.stopVideo.bind(this), delta * 1000);
        } else {
            this.player.pauseVideo();
            if ($.isFunction(this.options.onStop) && !this.wasStopped)
                this.options.onStop.call(this)
        }
    };

    this.startVideo = function() {
        this.player.playVideo();
        if ($.isFunction(this.options.onContinue))
            this.options.onContinue.call(this)
    };

    this.init();
}

$.fn.youtube = function(method_or_options) {
    if (this.data('youtube'))
        this.data('youtube')[method_or_options]();
    else
        this.data('youtube', new YouTube(this, method_or_options));
};
