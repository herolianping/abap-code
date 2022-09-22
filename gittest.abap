report ygittest.

data: ls_request type zmms_ylback_send_req,
      ls_return  type zoas00003.
ls_request-zcontrol-ifnum = 'IFMM004'.
try.
    ls_request-zcontrol-guid = cl_system_uuid=>create_uuid_c32_static( ).
  catch cx_uuid_error.
endtry.

try.
    ls_request-zcontrol-packid = cl_system_uuid=>create_uuid_c22_static( ).
  catch cx_uuid_error.
endtry.
ls_request-zdata-wttaskid  = 'B-100011'.

"同步接口会有隐式提交，会导致前面的冲销bapi提交，以致接口返回失败时无法保证事务一致性。所以换成异步处理
call function 'ZFM_MM_SEND_YL_BACK_ASYN'
  exporting
    i_import = ls_request
  importing
    o_return = ls_return.


return.

