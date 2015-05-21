//
//  VendorMacro.h

//  第三方常量

#ifndef YouYou_VendorMacro_h
#define YouYou_VendorMacro_h

typedef enum  {
    HTTP_METHOD_TYPE_NONE = -1,
	HTTP_METHOD_TYPE_GET = 1,
	HTTP_METHOD_TYPE_POST = 2,
	HTTP_METHOD_TYPE_PUT = 3,
	HTTP_METHOD_TYPE_DELETE = 4,
} HTTP_METHOD_TYPE;

typedef enum BHUploadState : NSUInteger{
    STATE_UPLOAD_UNSTART = 0,   // 未开始
    STATE_UPLOADING,            // 正在上传
    STATE_UPLOAD_SUCCESSFUL,    // 上传成功
    STATE_UPLOAD_FAIL,          // 上传失败
    STATE_REUPLOAD              // 重新上传
}BHUploadState;

typedef enum BHRequestState : NSUInteger{
    STATE_REQUEST_UNSTART = 0,   // 未开始
    STATE_REQUESTING,            // 正在请求
    STATE_REQUEST_SUCCESSFUL,    // 上传成功
    STATE_REQUEST_FAIL,          // 上传失败
    STATE_REQUEST_CANCEL         // 请求取消
}BHRequestState;

#endif
