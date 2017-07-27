FFMPEG_LIBS=    libavdevice                        \
                libavformat                        \
                libavfilter                        \
                libavcodec                         \
                libswresample                      \
                libswscale                         \
                libavutil                          \


CFLAGS += -Wall -g   -Wno-write-strings -Wno-deprecated -Wno-sign-compare -std=c++11 -fopenmp
CFLAGS += -I./dmutil/ \
		  -I./dmfilter/ \
		  -I./dmframe/ \
		  -I./dmvideo/ \
		  -I./dmyuv/ \
		  -I./linux_support/include/ \
		  -I./dmstream \
		  -I./dmfacedetect \
		  -I./dmaction \
		  -I./dmfacedetect/face_alignment \
		  -I./dmfacedetect/face_alignment/liblinear \
		  -I./dmfacedetect/face_alignment/liblinear/blas \
		  -I /usr/local/include \
		  -I./dmsensitive_word
CFLAGS := $(shell pkg-config --cflags $(FFMPEG_LIBS))  $(CFLAGS) 
LDLIBS := -L./linux_support/lib/ $(shell pkg-config --libs $(FFMPEG_LIBS)) $(LDLIBS) -lm -lyuv -pthread \
-lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu \
 -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_nonfree -lopencv_objdetect -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab -lopencv_highgui \
-lx264 \
 -lSoundTouch 
CXXFLAGS += $(CFLAGS) 
EXAMPLES=      main
#EXAMPLES=      main_cient
DMFILTER = dmfilter/filtering \
		dmutil/dou_list \
		dmutil/parse_config \
		dmutil/dmutil \
		dmutil/constant \
		dmutil/neon_support \
		dmfilter/filtering_audio \
		dmfilter/rotate \
		dmfilter/frame_effect \
		dmfilter/audio_interface \
		dmfilter/audio_revmodel
DMFRAME = dmframe/dmframe  \
		dmframe/dmscale  \
		dmframe/mv_oneframe_right  \
		dmframe/mv_oneframe_left   \
		dmframe/mv_oneframe_black_blend  \
		dmframe/mv_doubleframe_blend  \
		dmframe/mv_oneframe_scale  \
		dmframe/mv_doubleframe_scale_blend  \
		dmframe/mv_doubleframe_up_blend  \
		dmframe/mv_doubleframe_left_blend  \
		dmframe/mv_doubleframe_right_blend  \
		dmframe/mv_doubleframe_insert   \
		dmframe/mv_oneframe_trans  \
		dmframe/mv_oneframe_chongying  \
		dmframe/mv_oneframe_insert   \
		dmframe/mv_oneframe_drag  \
		dmframe/mv_oneframe_zoomout  \
		dmframe/mv_oneframe_openwin  \
		dmframe/mv_oneframe_scale_left  \
		dmframe/mv_oneframe_scale_down  \
		dmframe/mv_oneframe_zoomout_dance_single  \
		dmframe/mv_oneframe_zoomout_dance_group	\
		dmframe/mv_oneframe_speed  \
		dmframe/mv_oneframe_zoomout_blend \
		dmframe/mv_oneframe_speed_scale \
		dmframe/mv_oneframe_four_to_one \
		dmframe/mv_oneframe_four_to_one_openwin \
		dmframe/mv_oneframe_four_to_one_down_rectangle_out \
		dmframe/mv_oneframe_four_to_one_square_inout \
		dmframe/mv_oneframe_push \
		dmframe/mv_oneframe_onedown_oneup_onedown \
		dmframe/mv_oneframe_oneup_onedown_oneup \
		dmframe/mv_oneframe_oneright_oneleft_oneright \
		dmframe/mv_oneframe_four_to_one_rectangle_leftright \
		dmframe/mv_doubleframe_border_zoomin \
		dmframe/mv_doubleframe_rotate_border_zoomin \
		dmframe/mvutil 
DMVIDEO = dmvideo/dmvideo  \
		dmvideo/metadate \
		dmvideo/video_map \
		dmvideo/decode \
		dmvideo/play_show 
DMSTREAM = dmstream/vstream  \
		dmstream/astream  \
		dmstream/x264encode \
		dmstream/rgbencode  
DMYUV = dmyuv/yuvplayer \
		dmyuv/yuvreader  
DMFACE = dmfacedetect/flandmark_detector \
		 dmfacedetect/liblbp \
		 dmfacedetect/flandmark \
		 dmfacedetect/remove_logo \
		 dmfacedetect/face_detect \
		 dmfacedetect/face_alignment/LBFRegressor \
		 dmfacedetect/face_alignment/RandomForest \
		 dmfacedetect/face_alignment/Tree \
		 dmfacedetect/face_alignment/Utils \
		 dmfacedetect/face_alignment/face_alignment \
		 dmfacedetect/face_alignment/liblinear/linear \
		 dmfacedetect/face_alignment/liblinear/tron \
		 dmfacedetect/face_alignment/liblinear/blas/daxpy \
		 dmfacedetect/face_alignment/liblinear/blas/ddot \
		 dmfacedetect/face_alignment/liblinear/blas/dnrm2 \
		 dmfacedetect/face_alignment/liblinear/blas/dscal
DMACTION = dmaction/dmaction \
		   dmaction/action_add_filter \
		   dmaction/action_add_static_map \
		   dmaction/action_add_dong_map \
		   dmaction/action_blend_apng \
		   dmaction/action_delete_frame \
		   dmaction/action_increase_frame \
		   dmaction/action_scale_blend \
		   dmaction/action_up_blend \
		   dmaction/action_left_blend \
		   dmaction/action_right_blend
DMSENSITIVE_WORD = dmsensitive_word/Filter \
		dmsensitive_word/Tree \
		dmsensitive_word/TreeNode \
		dmsensitive_word/Process
SRC_DATA=$(EXAMPLES) \
		  $(DMFILTER) \
		  $(DMFRAME) \
		  $(DMVIDEO) \
		  $(DMSTREAM) \
		  $(DMYUV) \
		  $(DMFACE) \
		  $(DMACTION) 
		
OBJS=$(addsuffix .o,$(SRC_DATA))
SRC  := $(addsuffix .cpp,$(SRC_DATA))
TARGET := main
.PHONY : clean all
all: $(TARGET)
$(TARGET):$(OBJS)
	g++ $(CFLAGS)  $(OBJS) $(LDLIBS)  -o $(TARGET)
#	g++ $(CFLAGS) -fPIC -shared $(OBJS) $(LDLIBS)  -o $(TARGET).so
clean-test:
	$(RM) test*.pgm test.h264 test.mp2 test.sw test.mpg
	@echo $(CFLAGS)
	@echo $(LDLIBS)
clean: clean-test
	$(RM) $(EXAMPLES) $(OBJS) 
