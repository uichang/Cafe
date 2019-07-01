function LoginCheck(){
        	 var idStr = $("#id_lo").val();
        	 var pwStr = $("#pw_lo").val();
             if(idStr.trim()==""){
                alert("아이디를 입력해주세요");
                $('#id_lo').val('');
                return;
             }else if(pwStr.trim()==""){
                 alert("비밀번호를 입력해주세요");
                 $('#pw_lo').val('');
                 return;
              }
             $.ajax({
           	  url : "member.do?m=login&id="+idStr+"&pw="+pwStr+"&c_code="+c_code,
                 success : function(data){
                	  if(data == "success"){
                         document.getElementById('log').style.display='none'
                         location.href = "index.do";
                      }
                	  else if(data == "fail"){
                           alert("로그인 실패");
                           document.login_form.pw.value = "";
                           document.login_form.id.value = "";
                           document.login_form.id.focus();
                      }
                 }
             });
         }