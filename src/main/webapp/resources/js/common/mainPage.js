$(document).ready(function () {
	$(".mySlideDiv").not(".active").hide(); //화면 로딩 후 첫번째 div를 제외한 나머지 숨김
	
	setInterval(nextSlide, 4000); //4초(4000)마다 다음 슬라이드로 넘어감
});

//이전 슬라이드
function prevSlide() {
	$(".mySlideDiv").hide(); //모든 div 숨김
	var allSlide = $(".mySlideDiv"); //모든 div 객체를 변수에 저장
	var currentIndex = 0; //현재 나타난 슬라이드의 인덱스 변수
	
	//반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
	$(".mySlideDiv").each(function(index,item){ 
		if($(this).hasClass("active")) {
			currentIndex = index;
		}
        
	});
	
	//새롭게 나타낼 div의 index
	var newIndex = 0;
    
	if(currentIndex <= 0) {
		//현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
		newIndex = allSlide.length-1;
	} else {
		//현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
		newIndex = currentIndex-1;
	}

	//모든 div에서 active 클래스 제거
	$(".mySlideDiv").removeClass("active");
    
	//새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
	$(".mySlideDiv").eq(newIndex).addClass("active");
	$(".mySlideDiv").eq(newIndex).show();

}

//다음 슬라이드
function nextSlide() {
	$(".mySlideDiv").hide();
	var allSlide = $(".mySlideDiv");
	var currentIndex = 0;
	
	$(".mySlideDiv").each(function(index,item){
		if($(this).hasClass("active")) {
			currentIndex = index;
		}
        
	});
	
	var newIndex = 0;
	
	if(currentIndex >= allSlide.length-1) {
		//현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
		newIndex = 0;
	} else {
		//현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
		newIndex = currentIndex+1;
	}

	$(".mySlideDiv").removeClass("active");
	$(".mySlideDiv").eq(newIndex).addClass("active");
	$(".mySlideDiv").eq(newIndex).show();
	
}



$('a').click(function() {
    $('html, body').animate({
        scrollTop: $($.attr(this, 'href')).offset().top
    }, 500);
    return false;
});

// 퀵메뉴
$('.f16').click(function() {
    // 버튼 클릭 이벤트
	let idx = $(this).index()
	$('.f16').removeClass('on');
    $(this).addClass('on');
   
});

var sections = $('.target'),
    nav = $('.quick_menu'),
    nav_height = nav.outerHeight();

$(window).on('scroll', function() {
    var cur_pos = $(this).scrollTop();

    sections.each(function() {
        var top = $(this).offset().top - nav_height,
            bottom = top + $(this).outerHeight();

        if (cur_pos >= top && cur_pos <= bottom) {
            nav.find('a').parent().removeClass('on');
            sections.removeClass('active');

            $(this).parent().addClass('on');
            nav.find('a[href="#' + $(this).attr('id') + '"]').parent().addClass('on');
        }
    });
});

nav.find('a').on('click', function() {
    var $el = $(this),
        id = $el.attr('href');

    $('html, body').animate({
        scrollTop: $(id).offset().top 
    }, 500);

    return false;
});



$(window).on('scroll', function() {
    //스크롤의 위치가 상단에서 760보다 크면
    if ($(window).scrollTop() > 520) {
        /* if(window.pageYOffset >= $('원하는위치의엘리먼트').offset().top){ */
        $('.quick_menu').addClass("fixed");
        //위의 if문에 대한 조건 만족시 fixed라는 class를 부여함
    } else {
        $('.quick_menu').addClass("fixed");
        //위의 if문에 대한 조건 아닌경우 fixed라는 class를 삭제함
    }
})

$(function(){
    $(".click1").mouseenter(function () {
        $(this).addClass("hover");
      })
  });

$(function(){
  $(".click1").mouseleave(function () {
      $(this).removeClass("hover");
    })
});