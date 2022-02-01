package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOTelefoneRepository;
import dao.DAOUsuarioRepository;
import model.ModelLogin;
import model.ModelTelefone;

@WebServlet("/ServletTelefone")
public class ServletTelefone extends ServletGenericUtil {

	private static final long serialVersionUID = 1L;

	private DAOUsuarioRepository usuarioRepository = new DAOUsuarioRepository();
	
	private DAOTelefoneRepository telefoneRepository = new DAOTelefoneRepository();

	public ServletTelefone() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equals("excluirTelefone")) {
				
				String idTelefone = request.getParameter("idTelefone");
				telefoneRepository.deletarTelefone(Long.parseLong(idTelefone));
				
				String userPai = request.getParameter("userPai");
				//consulta o objeto para retornar para a tela
				ModelLogin modelUsuario = usuarioRepository.consultaUsuarioPorID(Long.parseLong(userPai));
				
				
				//setando a lista de telefones da lista pai
				List<ModelTelefone> listaDeTelefones = telefoneRepository.listaDeTelefonesUsers(modelUsuario.getId());
				//carrega a lista de telefones
				request.setAttribute("listaDeTelefones", listaDeTelefones);

				// passa o usuário e objeto inteiro
				request.setAttribute("modelUsuario", modelUsuario);
				request.setAttribute("mensagem", "Registro excluído com sucesso!");
				request.getRequestDispatcher("principal/telefone.jsp").forward(request, response);
				
				//e para não executar o bloco abaixo, é só dar um retorno
				return;
			}

			String idUser = request.getParameter("idUser");
			// System.out.println(idUser);

			if (idUser != null && !idUser.isEmpty()) {

				ModelLogin modelUsuario = usuarioRepository.consultaUsuarioPorID(Long.parseLong(idUser));
				
				//setando a lista de telefones da lista pai
				List<ModelTelefone> listaDeTelefones = telefoneRepository.listaDeTelefonesUsers(modelUsuario.getId());
				
				request.setAttribute("listaDeTelefones", listaDeTelefones);

				// passa o usuário e objeto inteiro
				request.setAttribute("modelUsuario", modelUsuario);
				request.getRequestDispatcher("principal/telefone.jsp").forward(request, response);

			} else {

				// consulta os dados no banco
				List<ModelLogin> modelLogins = usuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				// depois seta os atributos do usuario na tabela
				request.setAttribute("modelLogins", modelLogins);
				request.setAttribute("totalPagina", usuarioRepository.totalDePaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);

			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		try {
			
			String usuario_pai_id = request.getParameter("id");
			String numero = request.getParameter("numero");

			ModelTelefone modelTelefone = new ModelTelefone();
			modelTelefone.setNumero(numero);
			//passa o usuário pai
			modelTelefone.setUsuario_pai_id(usuarioRepository.consultaUsuarioPorID(Long.parseLong(usuario_pai_id)));
			//passa o usuário de cadastro
			modelTelefone.setUsuario_cad_id(super.getUserLogadoObject(request));
			
			telefoneRepository.gravarTelefone(modelTelefone);
			
			//setando a lista de telefones
			List<ModelTelefone> listaDeTelefones = telefoneRepository.listaDeTelefonesUsers(Long.parseLong(usuario_pai_id));
			
			ModelLogin modelUsuario = usuarioRepository.consultaUsuarioPorID(Long.parseLong(usuario_pai_id));
			// passa o usuário e objeto inteiro
			request.setAttribute("modelUsuario", modelUsuario);
			request.setAttribute("listaDeTelefones", listaDeTelefones);
			
			request.setAttribute("mensagem", "Registro gravado com sucesso!");
			request.getRequestDispatcher("principal/telefone.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
