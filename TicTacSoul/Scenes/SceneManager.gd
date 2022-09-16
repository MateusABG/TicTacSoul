extends Node




func play_animation(winner): 
	var local_nodes=get_node("%Board").local_nodes.duplicate()
	if([winner,winner,winner] == [local_nodes[0][0],local_nodes[0][1],local_nodes[0][2]]):
		$LinhaSuperior.visible=true
		$LinhaSuperior.play()
	elif([winner,winner,winner] == [local_nodes[1][0],local_nodes[1][1],local_nodes[1][2]]):
		$LinhaCentral.visible=true
		$LinhaCentral.play() 
	elif([winner,winner,winner] == [local_nodes[2][0],local_nodes[2][1],local_nodes[2][2]]):
		$LinhaInferior.visible=true
		$LinhaInferior.play()
	elif([winner,winner,winner] == [local_nodes[0][0],local_nodes[1][1],local_nodes[2][2]]):
		$DiagonalEsquerda.visible=true
		$DiagonalEsquerda.play()
	elif([winner,winner,winner] ==[local_nodes[0][2],local_nodes[1][1],local_nodes[2][0]]):
		$DiagonalDireita.visible=true
		$DiagonalDireita.play() 
	elif([winner,winner,winner] ==[local_nodes[0][0],local_nodes[1][0],local_nodes[2][0]]):
		$ColunaEsquerda.visible=true
		$ColunaEsquerda.play()
	elif([winner,winner,winner] == [local_nodes[0][1],local_nodes[1][1],local_nodes[2][1]]):
		$ColunaCentral.visible=true
		$ColunaCentral.play()
	elif([winner,winner,winner] == [local_nodes[0][2],local_nodes[1][2],local_nodes[2][2]]):
		$ColunaDireita.visible=true
		$ColunaDireita.play()
