

Crie um banco de dados para gerenciar cursos e suas matrículas.
O banco precisa armazenar: professores, alunos, cursos, disciplinas, curriculo (vincula curso à disciplina) e turma (vincula professor a disciplina)

Para professor:
- o nome é um campo obrigatório;
- o RG é um atributo que tem valor único para cada professor
- o sexo pode ser: 'M' ou 'F'
- o idade deve estar entre 21 e 70 anos
- o titulação deve ser: 'especialista', 'mestre', 'doutor' pu 'pós-doutor'
- o categoria deve ser: 'auxiliar', 'assistente', 'adjunto' ou 'titular'
- para a titulação doutor ou superior, a categoria só pode ser adjunto ou titular
- para a titulação mestre, a categoria só pode ser assistente
- para a titulação especialista, a categoria só pode ser auxiliar
- um campo NumeroTurmas deve existir, e toda vez que uma turma for excluída ou inserida, esse valor deve ser decrementado ou incrementado
- todo dia 31 do mês de dezembro incrementar 1 à idade do professor

Para disciplinas
- o nome é um atributo obrigatório
- o número de créditos deve estar entre 2 e 12
- o semestre da disciplina deve ser compativel com o numero de semestres do curso que esta vinculada

Para curso
- o nome é um atributo obrigatório;
- o duração deve estar entre 6 e 12 semestres
- o coordenador é uma chave estrangeira para Professores

Para turma
- vagas deve ser maior que zero;

Para currículos
- O semestre deve estar entre 1 e 12

