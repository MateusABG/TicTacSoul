extends Node



#Seleciona a animação de vitória para a respectiva coluna,linha ou diagonal
#e toca a animação deste local
func play_animation(winner): 
	var local_nodes=get_node("%Tabuleiro").nodos_locais.duplicate() 
	if([winner,winner,winner] == [local_nodes[0][0],local_nodes[0][1],local_nodes[0][2]]):
		$LinhaSuperior.visible=true
		$LinhaSuperior.play() 
		$Slide.play()
		yield(get_tree().create_timer(0.5),"timeout")
		$LinhaSuperior.stop()
		$Slide.stop()
	elif([winner,winner,winner] == [local_nodes[1][0],local_nodes[1][1],local_nodes[1][2]]):
		$LinhaCentral.visible=true
		$LinhaCentral.play()   
		$Slide.play()
		yield(get_tree().create_timer(0.6),"timeout")
		$LinhaCentral.stop()
		$Slide.stop()
	elif([winner,winner,winner] == [local_nodes[2][0],local_nodes[2][1],local_nodes[2][2]]):
		$LinhaInferior.visible=true
		$LinhaInferior.play() 
		$Slide.play()
		yield(get_tree().create_timer(0.6),"timeout")
		$LinhaInferior.stop()
		$Slide.stop()
	elif([winner,winner,winner] == [local_nodes[0][0],local_nodes[1][1],local_nodes[2][2]]):
		$DiagonalEsquerda.visible=true
		$DiagonalEsquerda.play()  
		$Slide.play()
		yield(get_tree().create_timer(0.6),"timeout")
		$DiagonalEsquerda.stop()
		$Slide.stop()
	elif([winner,winner,winner] ==[local_nodes[0][2],local_nodes[1][1],local_nodes[2][0]]):
		$DiagonalDireita.visible=true
		$DiagonalDireita.play()  
		$Slide.play()
		yield(get_tree().create_timer(0.6),"timeout")
		$DiagonalDireita.stop()
		$Slide.stop()
	elif([winner,winner,winner] ==[local_nodes[0][0],local_nodes[1][0],local_nodes[2][0]]):
		$ColunaEsquerda.visible=true
		$ColunaEsquerda.play() 
		$Slide.play()
		yield(get_tree().create_timer(0.6),"timeout")
		$ColunaEsquerda.stop()
		$Slide.stop()
	elif([winner,winner,winner] == [local_nodes[0][1],local_nodes[1][1],local_nodes[2][1]]):
		$ColunaCentral.visible=true
		$ColunaCentral.play() 
		$Slide.play()
		yield(get_tree().create_timer(0.6),"timeout")
		$ColunaCentral.stop()
		$Slide.stop()
	elif([winner,winner,winner] == [local_nodes[0][2],local_nodes[1][2],local_nodes[2][2]]):
		$ColunaDireita.visible=true
		$ColunaDireita.play() 
		$Slide.play()
		yield(get_tree().create_timer(0.6),"timeout")
		$ColunaDireita.stop()
		$Slide.stop()
