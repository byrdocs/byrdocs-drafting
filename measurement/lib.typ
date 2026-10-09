#import "@preview/cetz:0.5.2"
#let red=rgb("e05036")
#let green=rgb("077c30")
#let blue=rgb("0c61c0")
#let counter-line=counter("counter-line")
#let preset(img-path,dx:0,dy:0,scale:100%,rot:0deg,width:5376,height:4032,body)={
	assert(width==4032 or height==4032)//画幅的短边必须设定为4032
	assert(width>=4032 and height>=4032)//不得出现比4032更短的边
	let foreground=context cetz.canvas(x:1pt,y:1pt,{
		cetz.draw.rect((0,0),(page.width.pt(),page.height.pt()))
		if sys.inputs.at("RULER",default:"0")=="1" {
			let densely-stroke=(
				thickness:5pt,
				dash:(11pt,14pt),
			)
			let loosely-stroke=(
				thickness:3pt,
				dash:(5pt,25pt),
			)
			for x in range(0,width,step:200) {
				cetz.draw.line(
					(x,0),(x,height),
					stroke:if calc.rem(x,1000)==0 {
						densely-stroke
					} else {
						loosely-stroke
					},
				)
			}
			for y in range(0,height,step:200) {
				cetz.draw.line(
					(0,y),(width,y),
					stroke:if calc.rem(y,1000)==0 {
						densely-stroke
					} else {
						loosely-stroke
					},
				)
			}
		}
	})
	set page(
		width:1pt*width,
		height:1pt*height,
		margin:0pt,
		background:move(
			rotate(
				rot,
				image(
					img-path,
					width:scale,
					height:scale,
				),
			),
			dx:1pt*dx,
			dy:1pt*dy,
		),
		foreground:foreground,
	)
	set text(
		size:144pt,
		weight:"extrabold",
		font:(
			"Noto Sans",
			"Noto Sans CJK SC",
		),
	)
	set text(
		stroke:(
			paint:white,
			thickness:3pt,
			join:"round",
		),
	)
	body
}
#let canvas(body)=cetz.canvas(x:1pt,y:1pt,{
	cetz.draw.rect((0,0),(page.width.pt(),page.height.pt()))
	cetz.draw.floating({
		cetz.draw.content((page.width.pt()-400,125),[单位：cm])
		body
	})
})
#let dash-line(a,b,fill)=cetz.draw.line(
	a,b,
	stroke:(
		paint:fill,
		thickness:15pt,
		dash:(25pt,20pt),
	),
)
#let helping-line(a,b,fill:gray)=if sys.inputs.at("HELPING_LINE",default:"0")=="1" {
	cetz.draw.line(
		a,b,
		stroke:(
			paint:fill,
			thickness:5pt,
		),
	)
}
#let anno-line(a,b,fill,rel:50%,pad:1.5,shift:false,body)={
	let line-name=str(counter-line.get().first())
	let mark-style=(
		symbol:">",
		fill:fill,
		length:0.6cm,
		width:0.75cm,
	)
	cetz.draw.line(
		a,b,
		stroke:(
			paint:fill,
			thickness:15pt,
		),
		mark:(
			start:mark-style,
			end:mark-style,
		),
		name:line-name,
	)
	let content-position=(line-name+".start",rel,line-name+".end")
	cetz.draw.content(
		content-position,
		anchor:calc.atan2(b.at(0)-a.at(0),b.at(1)-a.at(1))+if shift {
			90deg
		} else {
			-90deg
		},
		padding:pad,
		text(fill:fill,body)
	)
}
