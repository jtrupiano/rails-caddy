module RailsCaddyHelper
  # actually embeds the magic that is the Rails Caddy
  def rails_caddy
    html = <<-HTML
      <style type="text/css">
        #railsCaddy {
          text-align: left;
        	position: absolute;
        	width: auto;
        	height: auto;
        	top: 100px;
        	left: 0px;
        	background-image: url(images/background.gif);
        	background-position: top left;
        	background-repeat: repeat-y;
        }

        #railsCaddyTab {
        	float: left;
        	height: 137px;
        	width: 28px;
        }

        #railsCaddyTab img {
          border: none;
        }

        #railsCaddyContents {
        	float: left;
        	overflow: hidden !important;
        	width: 200px;
        }

        #railsCaddyContentsInner {
        	width: 200px;
        	margin-top: 30px;
        }

        #railsCaddyContentsInner > div {
          border: solid 1px red;
        }

        #railsCaddyContentsInner h2 {
        	margin: 0px 0px 3px 0px;
        	padding: 2px;
        	background-color: #CC3400;
        	color: #FFFFFF;
        	font-size: 14px;
        }
      </style>
      
      #{render(:partial => '/rails_caddy')}
    HTML
  end
end