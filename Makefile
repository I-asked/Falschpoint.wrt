ZIP ?= zip
CLOSC ?= closure-compiler

TN := falschpoint

SRCS := \
	$(TN)/Info.plist \
	$(TN)/Icon.png \
	$(TN)/phonegap.js \
	$(TN)/assets/fplogo52.png \
	$(TN)/assets/placeholder_shot.png \
	$(TN)/assets/placeholder_logo.png \
	$(TN)/index.min.js \
	$(TN)/index.css \
	$(TN)/index.html
SRCS += \
	$(TN)/promise.min.js \
	$(TN)/fetch.min.js
SRCS += \
	$(TN)/jquery/jquery-1.11.1.min.js \
	$(TN)/jquery/jquery.mobile-1.4.5.min.js \
	$(TN)/jquery/jquery.mobile-1.4.5.min.css \
	$(TN)/jquery/images/icons-png/action-black.png \
	$(TN)/jquery/images/icons-png/action-white.png \
	$(TN)/jquery/images/icons-png/alert-black.png \
	$(TN)/jquery/images/icons-png/alert-white.png \
	$(TN)/jquery/images/icons-png/arrow-d-black.png \
	$(TN)/jquery/images/icons-png/arrow-d-l-black.png \
	$(TN)/jquery/images/icons-png/arrow-d-l-white.png \
	$(TN)/jquery/images/icons-png/arrow-d-r-black.png \
	$(TN)/jquery/images/icons-png/arrow-d-r-white.png \
	$(TN)/jquery/images/icons-png/arrow-d-white.png \
	$(TN)/jquery/images/icons-png/arrow-l-black.png \
	$(TN)/jquery/images/icons-png/arrow-l-white.png \
	$(TN)/jquery/images/icons-png/arrow-r-black.png \
	$(TN)/jquery/images/icons-png/arrow-r-white.png \
	$(TN)/jquery/images/icons-png/arrow-u-black.png \
	$(TN)/jquery/images/icons-png/arrow-u-l-black.png \
	$(TN)/jquery/images/icons-png/arrow-u-l-white.png \
	$(TN)/jquery/images/icons-png/arrow-u-r-black.png \
	$(TN)/jquery/images/icons-png/arrow-u-r-white.png \
	$(TN)/jquery/images/icons-png/arrow-u-white.png \
	$(TN)/jquery/images/icons-png/audio-black.png \
	$(TN)/jquery/images/icons-png/audio-white.png \
	$(TN)/jquery/images/icons-png/back-black.png \
	$(TN)/jquery/images/icons-png/back-white.png \
	$(TN)/jquery/images/icons-png/bars-black.png \
	$(TN)/jquery/images/icons-png/bars-white.png \
	$(TN)/jquery/images/icons-png/bullets-black.png \
	$(TN)/jquery/images/icons-png/bullets-white.png \
	$(TN)/jquery/images/icons-png/calendar-black.png \
	$(TN)/jquery/images/icons-png/calendar-white.png \
	$(TN)/jquery/images/icons-png/camera-black.png \
	$(TN)/jquery/images/icons-png/camera-white.png \
	$(TN)/jquery/images/icons-png/carat-d-black.png \
	$(TN)/jquery/images/icons-png/carat-d-white.png \
	$(TN)/jquery/images/icons-png/carat-l-black.png \
	$(TN)/jquery/images/icons-png/carat-l-white.png \
	$(TN)/jquery/images/icons-png/carat-r-black.png \
	$(TN)/jquery/images/icons-png/carat-r-white.png \
	$(TN)/jquery/images/icons-png/carat-u-black.png \
	$(TN)/jquery/images/icons-png/carat-u-white.png \
	$(TN)/jquery/images/icons-png/check-black.png \
	$(TN)/jquery/images/icons-png/check-white.png \
	$(TN)/jquery/images/icons-png/clock-black.png \
	$(TN)/jquery/images/icons-png/clock-white.png \
	$(TN)/jquery/images/icons-png/cloud-black.png \
	$(TN)/jquery/images/icons-png/cloud-white.png \
	$(TN)/jquery/images/icons-png/comment-black.png \
	$(TN)/jquery/images/icons-png/comment-white.png \
	$(TN)/jquery/images/icons-png/delete-black.png \
	$(TN)/jquery/images/icons-png/delete-white.png \
	$(TN)/jquery/images/icons-png/edit-black.png \
	$(TN)/jquery/images/icons-png/edit-white.png \
	$(TN)/jquery/images/icons-png/eye-black.png \
	$(TN)/jquery/images/icons-png/eye-white.png \
	$(TN)/jquery/images/icons-png/forbidden-black.png \
	$(TN)/jquery/images/icons-png/forbidden-white.png \
	$(TN)/jquery/images/icons-png/forward-black.png \
	$(TN)/jquery/images/icons-png/forward-white.png \
	$(TN)/jquery/images/icons-png/gear-black.png \
	$(TN)/jquery/images/icons-png/gear-white.png \
	$(TN)/jquery/images/icons-png/grid-black.png \
	$(TN)/jquery/images/icons-png/grid-white.png \
	$(TN)/jquery/images/icons-png/heart-black.png \
	$(TN)/jquery/images/icons-png/heart-white.png \
	$(TN)/jquery/images/icons-png/home-black.png \
	$(TN)/jquery/images/icons-png/home-white.png \
	$(TN)/jquery/images/icons-png/info-black.png \
	$(TN)/jquery/images/icons-png/info-white.png \
	$(TN)/jquery/images/icons-png/location-black.png \
	$(TN)/jquery/images/icons-png/location-white.png \
	$(TN)/jquery/images/icons-png/lock-black.png \
	$(TN)/jquery/images/icons-png/lock-white.png \
	$(TN)/jquery/images/icons-png/mail-black.png \
	$(TN)/jquery/images/icons-png/mail-white.png \
	$(TN)/jquery/images/icons-png/minus-black.png \
	$(TN)/jquery/images/icons-png/minus-white.png \
	$(TN)/jquery/images/icons-png/navigation-black.png \
	$(TN)/jquery/images/icons-png/navigation-white.png \
	$(TN)/jquery/images/icons-png/phone-black.png \
	$(TN)/jquery/images/icons-png/phone-white.png \
	$(TN)/jquery/images/icons-png/plus-black.png \
	$(TN)/jquery/images/icons-png/plus-white.png \
	$(TN)/jquery/images/icons-png/power-black.png \
	$(TN)/jquery/images/icons-png/power-white.png \
	$(TN)/jquery/images/icons-png/recycle-black.png \
	$(TN)/jquery/images/icons-png/recycle-white.png \
	$(TN)/jquery/images/icons-png/refresh-black.png \
	$(TN)/jquery/images/icons-png/refresh-white.png \
	$(TN)/jquery/images/icons-png/search-black.png \
	$(TN)/jquery/images/icons-png/search-white.png \
	$(TN)/jquery/images/icons-png/shop-black.png \
	$(TN)/jquery/images/icons-png/shop-white.png \
	$(TN)/jquery/images/icons-png/star-black.png \
	$(TN)/jquery/images/icons-png/star-white.png \
	$(TN)/jquery/images/icons-png/tag-black.png \
	$(TN)/jquery/images/icons-png/tag-white.png \
	$(TN)/jquery/images/icons-png/user-black.png \
	$(TN)/jquery/images/icons-png/user-white.png \
	$(TN)/jquery/images/icons-png/video-black.png \
	$(TN)/jquery/images/icons-png/video-white.png \
	$(TN)/jquery/images/ajax-loader.gif

PG_SRCS := \
	js/phonegap.js.base \
	js/acceleration.js \
	js/accelerometer.js \
	js/audio.js \
	js/camera.js \
	js/camera/com.nokia.device.framework.js \
	js/camera/com.nokia.device.utility.js \
	js/camera/s60_camera.js \
	js/camera/com.nokia.device.camera.js \
	js/contacts.js \
	js/debugconsole.js \
	js/device.js \
	js/geolocation.js \
	js/map.js \
	js/network.js \
	js/notification.js \
	js/orientation.js \
	js/position.js \
	js/sms.js \
	js/storage.js \
	js/telephony.js

.PHONY: clean

$(TN).wgz: $(SRCS)
	$(ZIP) $@ $^

$(TN)/index.min.js: $(TN)/index.js
ifeq ($(shell command -v -- $(CLOSC)),)
	cat $^ >$@
else
	$(CLOSC) --language_in=ECMASCRIPT3 --language_out=ECMASCRIPT3 --js_output_file=$@ $^
endif

$(TN)/phonegap.js: $(PG_SRCS)
ifeq ($(shell command -v -- $(CLOSC)),)
	cat $^ >$@
else
	$(CLOSC) --language_in=ECMASCRIPT3 --language_out=ECMASCRIPT3 --js_output_file=$@ $^
endif

clean:
	$(RM) $(TN).wgz $(TN)/phonegap.js $(TN)/index.min.js
