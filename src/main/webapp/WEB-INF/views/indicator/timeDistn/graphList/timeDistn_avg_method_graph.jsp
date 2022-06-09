<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

	　	
		<c:forEach items="${jsonListTm}" var="item" varStatus="status">
			
		  <div class="table01">
            <div class="option">
              <button onclick="resetZoomChart_${status.index}()" class="resetZoomChart" id="resetZoomChart">새로고침</button>
              <label><input class="legend" id='legend_${status.index}' type="checkbox" value="범례" checked="on">범례</label>
              
              <div class="Icon">
                <p class="Icon_01" id="Icon_${status.index}">?</p>
                <div class="modal" id="modal_${status.index}">
                  <div class="modal-title">도움말</div>
                    <div class="modal-content">
                    <ul>
                      <li>마우스 휠을 이용하여 그래프 확대/축소가 가능합니다.</li>
                      <li>원하는 구간은 드래그로 지정하여 확대할 수 있습니다.</li>
                      <li>alt키를 누르면서 클릭하면 상하좌우로 이동할 수 있습니다.</li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
            <div class="chart01" style="margin-bottom: 2%;">
                <div class="chart_${status.index}" style="width: 100%;height: 94%;">
                  <p  style="font-weight: bolder; text-align: center; margin-top: 0.5%;">${dateList[status.index]}</p>
                  <canvas id = "myChart02_${status.index}" style="width: 50%; height: 100%; background: #fff; float: left;" ></canvas>
                  <canvas id = "myChart01_${status.index}" style="width: 50%; height: 100%; background: #fff; float: left;" ></canvas>
                </div>
            </div>
          </div>
	
		</c:forEach>
		
		
		<script>
			<c:forEach items="${jsonListTm}" var="item" varStatus="status">
			
				
					//모달
					 $('#Icon_${status.index}').mouseover(function(){
			          	console.log(0)
			          	$('#modal_${status.index}').addClass('active');
		          	});
			
		        	$('#Icon_${status.index}').mouseleave(function(){
		        		$('#modal_${status.index}').removeClass('active');
		        	});
		
		          //체크박스 범례 설정
		          document.getElementById('legend_${status.index}').addEventListener('click', function() {
					chart1_${status.index}.options.plugins.legend.display=!chart1_${status.index}.options.plugins.legend.display;
		            chart1_${status.index}.update();
		            chart2_${status.index}.options.plugins.legend.display=!chart2_${status.index}.options.plugins.legend.display;
		            chart2_${status.index}.update();
		          });
		       
		          
		          //새로고침
		          function resetZoomChart_${status.index}(){
		            chart1_${status.index}.resetZoom();
		            chart2_${status.index}.resetZoom();
		          }
		       
		          //         수단통행은 합계
		
		          // 차트그리기
					var ctx_${status.index} = document.getElementById('myChart01_${status.index}').getContext('2d');
		    		var chart1_${status.index} = new Chart(ctx_${status.index}, {
		           	type: 'bar', 
		            data: {
		                labels:  ${labels}, // 큰 분류(하단 데이터 이름) 수단
		                datasets: ${jsonListTm[status.index]}
					},
					 options: {
			              responsive : false,
			              interaction: {
			                    intersect: false,
			                    mode: 'index'
			                },
			              scales:{
			                x: {
			                title: {
			                    display: true,
			                    text: '이용자유형'
			                }
			            },
			            y: {
			                  position: 'left',
			                  beginAtZero:true,
			                  title: {
			                    display: true,
			                    text: '평균거리'
			                }
			                }
			              },
			        plugins: {
			            legend: {
			                display: true,
			                position:'right',       //범례위치
			                align : 'start',        //범례 위쪽 정렬
			                labels: {
			                    boxHeight : 5,
			                    boxWidth : 20
			                }
			            },
			            zoom: {
													pan: {
														enabled: true,
														mode:'xy',
														threshold: 10,
														modifierKey: 'alt'
													},
													zoom: {
			                      mode:'x',
														wheel: {
															enabled: true,
															speed:2
														},
			                      drag: {
															enabled:true,
															backgroundColor: 'rgba(250,238,134,0.3)',
															borderColor: 'rgba(250,238,134,1)',
															borderWidth: 1,
			                        threshole:100
														},
														
														pinch:{
															enabled:true
														}
													}
												},
			                  title: {
			                    display: true,
			                    text: '거리',
			                    font: { // [타이틀 폰트 스타일 변경]
			    							family: 'Comic Sans MS',
			    							size: 15,
			    							weight: 'bold',
			    							lineHeight: 1.2,    							
			    						},
			    						padding: {top: 20, left: 0, right: 0, bottom: 0}           //제목
			                  },
			   	 	 }
			   		 }
		        });
		        //2번째 차트
		        var ctx_${status.index} = document.getElementById('myChart02_${status.index}').getContext('2d');
		    				var chart2_${status.index} = new Chart(ctx_${status.index}, {
		           	 type: 'bar', 
		            data: {
		                labels: ${labels}, // 큰 분류(하단 데이터 이름) 수단
		                datasets: ${jsonListDst[status.index]}
					},
		            options: {
			              responsive : false,
			              interaction: {
			                    intersect: false,
			                    mode: 'index'
			                },
			              scales:{
			                x: {
			                title: {
			                    display: true,
			                    text: '이용자유형'
			                }
			            },
			            y: {
			                  position: 'left',
			                  beginAtZero:true,
			                  title: {
			                    display: true,
			                    text: '평균시간'
			                }
			                }
			              },
			        plugins: {
			            legend: {
			                display: true,
			                position:'right',       //범례위치
			                align : 'start',        //범례 위쪽 정렬
			                labels: {
			                    boxHeight : 5,
			                    boxWidth : 20
			                }
			            },
			            zoom: {
													pan: {
														enabled: true,
														mode:'xy',
														threshold: 10,
														modifierKey: 'alt'
													},
													zoom: {
			                      mode:'x',
														wheel: {
															enabled: true,
															speed:2
														},
			                      drag: {
															enabled:true,
															backgroundColor: 'rgba(250,238,134,0.3)',
															borderColor: 'rgba(250,238,134,1)',
															borderWidth: 1,
			                        threshole:100
														},
														
														pinch:{
															enabled:true
														}
													}
												},
			                  title: {
			                    display: true,
			                    text: '시간',
			                    font: { // [타이틀 폰트 스타일 변경]
			    							family: 'Comic Sans MS',
			    							size: 15,
			    							weight: 'bold',
			    							lineHeight: 1.2,    							
			    						},
			    						padding: {top: 20, left: 0, right: 0, bottom: 0}           //제목
			                  },
			    }
			    }
		        });
			
			</c:forEach>
		</script>
		
