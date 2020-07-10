var db = null;
var var_no = null;
var position = null;
var index;

// 데이터베이스 생성 및 오픈
function openDB(){
	db = window.openDatabase('testDB', '1.0', 'testDB', 1024*1024*10); 
	console.log('1_DB 생성...'); 
} 
// 테이블 생성 트랜잭션 실행
function createTable() {
	db.transaction(	//SQL실행문, 파라미터, 성공, 실패
		function(tr){
			var createSQL = 'CREATE TABLE IF NOT EXISTS TEST(id, pw, phone, gender, year)';
			var createSQL2 = 'CREATE TABLE IF NOT EXISTS TEST2(id, subject, day, start_time, end_time)';
			tr.executeSql(	//SQL명령, 파라미터, 성공, 실패
				createSQL,
				[],
				function(){
					console.log('2_1_유저테이블생성_sql 실행 성공...');        
				}, 
				function(){
					console.log('2_1_유저테이블생성_sql 실행 실패...');            
				}
				);

			tr.executeSql(	//SQL명령, 파라미터, 성공, 실패
				createSQL2,
				[],
				function(){
					console.log('2_2_과목테이블생성_sql 실행 성공...');        
				}, 
				function(){
					console.log('2_2_과목테이블생성_sql 실행 실패...');            
				}
				);
		},
		[],
		function(){
			console.log('2_3_테이블 생성 트랜잭션 성공...');
		},
		function(){
			console.log('2_3_테이블 생성 트랜잭션 실패...롤백은 자동');
		}
		);
}
// 회원가입 데이터 입력 트랜잭션 실행
function signUser(){
	db.transaction(function(tr){
		var id = $('#si_user_id').val();
		var pw = $('#si_user_pw').val();
		var phone = $('#user_phone').val();
		var gender = $('#user_gender').val();
		var year = $('#user_year').val();
		if(id==""||pw==""||phone==""||gender==""||year==""){
			alert('입력이 안되었습니다.');
		}
		else{
			var insertSQL = 'INSERT INTO TEST(id, pw, phone, gender, year) VALUES(?, ?, ?, ?, ?)';
			tr.executeSql(insertSQL, [id, pw, phone, gender, year], function(tr, rs){	//성공시, 함수 실행, 매개변수로 결과문(?)과 결과를 넘겨줌..(???)
				console.log('3_2_유저 등록...no: ' + rs.insertId);	//insertId :rowid
				alert('환영합니다. ' + $('#si_user_id').val() + ' 님 !!!');
				$('#sineup_form')[0].reset();
			}, function(tr, err){
				alert('DB오류 ' + err.message + err.code);
			});
		}

		},//transaction 명령끝
		[],
		function(){
			console.log('3_3_회원가입 트랜잭션 종료...');
		},
		function(){
			console.log('3_3_회원가입 트랜잭션 실패...롤백은 자동');
		}
		);
}

//로그인 데이터 검색 트랜잭션 실행
function loginUser(){
	db.transaction(function(tr){
		var id = $('#lo_user_id').val();
		var pw = $('#lo_user_pw').val();
		var loginSQL = 'SELECT id, pw FROM TEST WHERE id= ? AND pw = ?';
		if(id==""||pw==""){
			alert('입력이 안되었습니다.');
		}
		else{
			tr.executeSql(loginSQL, [id,pw],function(tr, rs){
				if( rs.rows == "" || rs.rows == null || rs.rows == undefined || ( rs.rows != null && typeof rs.rows == "object" && !Object.keys(rs.rows).length ) ){
					console.log('4_1 로그인 조회 실패..');
				}
				else{
					console.log('4_1 로그인 조회 성공..');
					$('#hidden_index').text(1);
					$('#panel').append('<h1>'+rs.rows.item(0).id+" 님 <br>환영합니다.</h1>");
				}
			},
			function(tr,err){alert('DB오류 ' + err.message + err.code);}
			);
		}
	},//transaction 명령끝
	[],
	function(){
		console.log('4_2 로그인 트랜잭션 종료...');
	},
	function(){
		console.log('4_2 로그인 트랜잭션 실패...롤백은 자동');
	}
	);
}
//시간표 데이터 입력 트랜잭션 실행
function Schedule(){
	db.transaction(function(tr){
		var temp=$('#panel h1').text();
		var id = temp.split(" ");
		id=id[0];
		var subject = new Array();
		var day=$('#schedule_day').val();
		var start_time = new Array();
		var end_time = new Array();
		var schedule_length = $('input[name^=subject_name]').length;
		for (var i=0; i<schedule_length; i++){
			temp="input[name^=subject_name_"+(i+1)+"]"
			subject[i]=$(temp).val();
			temp="input[name^=start_time_"+(i+1)+"]"
			start_time[i]=$(temp).val();
			temp="input[name^=end_time_"+(i+1)+"]"
			end_time[i]=$(temp).val();
		}
		if(id==""||subject==""||start_time==""||end_time==""){
			alert('입력이 안되었습니다.');
		}
		else{
			for(var i=0; i<schedule_length; i++){
				if(id==""||subject[i]==""||start_time[i]==""||end_time[i]==""){console.log('5_1 시간표 내용 없음...');}
				else{
					var insertSQL = 'INSERT INTO TEST2(id, subject, day, start_time, end_time) VALUES(?, ?, ?, ?, ?, ?)';
					tr.executeSql(insertSQL, [id, subject[i], day, start_time[i],end_time[i]], function(tr, rs){    
						console.log('5_1 시간표 입력 중..');
						alert('시간표 입력이 완료 되었습니다.');
						$('#schedule_form')[0].reset();
					}, function(tr, err){
						alert('DB오류 ' + err.message + err.code);
					});
				}
			}
		}
		},//transaction 명령끝
		[],
		function(){
			console.log('5_2_시간표 입력 트랜잭션 종료...');
		},
		function(){
			console.log('5_2_시간표 입력 트랜잭션 실패...롤백은 자동');
		}
		);
}

//시간표 테이블 출력 트랜잭션 실행
//id, subject, day, start_time, end_time
function showTable(){
	db.transaction(function(tr){
		var temp=$('#panel h1').text();
		var id = temp.split(" ");
		var td_day="";
		var tr_stime="";
		var tr_etime="";
		id=id[0];
		var showSQL = 'SELECT * FROM TEST2 WHERE id= ?';
		tr.executeSql(showSQL, [id],function(tr, rs){
			for(var i = 0; i < rs.rows.length; i++){
				var row = rs.rows.item(i);
				if(row['day']=='월'){
					var randcolor="#"+Math.round(Math.random()*0xffffff).toString(16);
					td_day=2;
					tr_stime=row['start_time'].split(':');
					tr_stime=parseInt(tr_stime[0])-8
					tr_etime=row['end_time'].split(':');
					tr_etime=parseInt(tr_etime[0])-8
					var a=0;
					for(var x = tr_stime; x<=tr_etime;x++){
						temp='#content_table>tbody>tr:nth-child('+x+')>td:nth-child('+td_day+')'
						//#content_table>tbody>tr:nth-child(1)>td:nth-child(2)
											//tr이 시간으로 선택. td는 요일.
						$(temp).css('background-color',randcolor);
						$(temp).text(row['subject'][a]);
						a++;
					}
				}
				if(row['day']=='화'){
					var randcolor="#"+Math.round(Math.random()*0xffffff).toString(16);
					td_day=3;
					tr_stime=row['start_time'].split(':');
					tr_stime=parseInt(tr_stime[0])-8
					tr_etime=row['end_time'].split(':');
					tr_etime=parseInt(tr_etime[0])-8
					var a=0;
					for(var x = tr_stime; x<=tr_etime;x++){
						temp='#content_table>tbody>tr:nth-child('+x+')>td:nth-child('+td_day+')'
						//#content_table>tbody>tr:nth-child(1)>td:nth-child(2)
											//tr이 시간으로 선택. td는 요일.
						$(temp).css('background-color',randcolor);
						$(temp).text(row['subject'][a]);
						a++;
					}
				}
				if(row['day']=='수'){
					var randcolor="#"+Math.round(Math.random()*0xffffff).toString(16);
					td_day=4;
					tr_stime=row['start_time'].split(':');
					tr_stime=parseInt(tr_stime[0])-8
					tr_etime=row['end_time'].split(':');
					tr_etime=parseInt(tr_etime[0])-8
					var a=0;
					for(var x = tr_stime; x<=tr_etime;x++){
						temp='#content_table>tbody>tr:nth-child('+x+')>td:nth-child('+td_day+')'
						//#content_table>tbody>tr:nth-child(1)>td:nth-child(2)
											//tr이 시간으로 선택. td는 요일.
						$(temp).css('background-color',randcolor);
						$(temp).text(row['subject'][a]);
						a++;
					}
				}
				if(row['day']=='목'){
					var randcolor="#"+Math.round(Math.random()*0xffffff).toString(16);
					td_day=5;
					tr_stime=row['start_time'].split(':');
					tr_stime=parseInt(tr_stime[0])-8
					tr_etime=row['end_time'].split(':');
					tr_etime=parseInt(tr_etime[0])-8
					var a=0;
					for(var x = tr_stime; x<=tr_etime;x++){
						temp='#content_table>tbody>tr:nth-child('+x+')>td:nth-child('+td_day+')'
						//#content_table>tbody>tr:nth-child(1)>td:nth-child(2)
											//tr이 시간으로 선택. td는 요일.
						$(temp).css('background-color',randcolor);
						$(temp).text(row['subject'][a]);
						a++;
					}
				}
				if(row['day']=='금'){
					var randcolor="#"+Math.round(Math.random()*0xffffff).toString(16);
					td_day=6;
					tr_stime=row['start_time'].split(':');
					tr_stime=parseInt(tr_stime[0])-8
					tr_etime=row['end_time'].split(':');
					tr_etime=parseInt(tr_etime[0])-8
					var a=0;
					for(var x = tr_stime; x<=tr_etime;x++){
						temp='#content_table>tbody>tr:nth-child('+x+')>td:nth-child('+td_day+')'
						//#content_table>tbody>tr:nth-child(1)>td:nth-child(2)
											//tr이 시간으로 선택. td는 요일.
						$(temp).css('background-color',randcolor);
						$(temp).text(row['subject'][a]);
						a++;
					}
				}
				if(row['day']=='토'){
					var randcolor="#"+Math.round(Math.random()*0xffffff).toString(16);
					td_day=7;
					tr_stime=row['start_time'].split(':');
					tr_stime=parseInt(tr_stime[0])-8
					tr_etime=row['end_time'].split(':');
					tr_etime=parseInt(tr_etime[0])-8
					var a=0;
					for(var x = tr_stime; x<=tr_etime;x++){
						temp='#content_table>tbody>tr:nth-child('+x+')>td:nth-child('+td_day+')'
						//#content_table>tbody>tr:nth-child(1)>td:nth-child(2)
											//tr이 시간으로 선택. td는 요일.
						$(temp).css('background-color',randcolor);
						$(temp).text(row['subject'][a]);
						a++;
					}
				}
			}
		},
		function(tr,err){alert('DB오류 ' + err.message + err.code);}
		);
	},//transaction 명령끝
	[],
	function(){
		console.log('6_1_시간표 출력 트랜잭션 종료...');
	},
	function(){
		console.log('6_1_시간표 출력 트랜잭션 실패...롤백은 자동');
	}
	)
}

function all_delete(){
	db.transaction(function (tr) {
		tr.executeSql('DROP TABLE TEST')
		tr.executeSql('DROP TABLE TEST2')
	});
}
