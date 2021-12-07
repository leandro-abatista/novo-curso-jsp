package servlets;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dao.DAOUsuarioRepository;
import model.ModelLogin;


@WebServlet("/ServletUsuarioController")
public class ServletUsuarioController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
       
    
    public ServletUsuarioController() {
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
				
				String idUsuario = request.getParameter("id");
				daoUsuarioRepository.deletarUsuario(idUsuario);
				request.setAttribute("mensagem", "Registro excluído com sucesso!");
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarComAjax")) {/* usando o ajax para deletar usuário */
				
				String idUsuario = request.getParameter("id");
				daoUsuarioRepository.deletarUsuario(idUsuario);
				response.getWriter().write("Registro excluído com sucesso!");
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUsuarioComAjax")) {
				
				String nomeBusca = request.getParameter("nomeBusca");
				List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaListPorNome(nomeBusca);
				//response.getWriter().write("Registro excluído com sucesso!");
				//System.out.println(nomeBusca);
				 ObjectMapper mapper = new ObjectMapper();
				 String json = mapper.writeValueAsString(dadosJsonUser);
				 response.getWriter().write(json);
				
			} else {
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String mensagem = "Operação realizada com sucesso!";
			
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String login = request.getParameter("login");
			String senha = request.getParameter("senha");

			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelLogin.setNome(nome);
			modelLogin.setEmail(email);
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);

			if (daoUsuarioRepository.validaLogin(modelLogin.getLogin()) && modelLogin.getId() == null) {
				mensagem = "Já existe um usuario com o mesmo 'Login'.\nInforme um login válido!";
			} else {
				
				if(modelLogin.isNovo()){
					mensagem = "Registro gravado com sucesso!";
				} else {
					mensagem = "Registro atualizado com sucesso!";
				}
				
				modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin);
			}

			request.setAttribute("mensagem", mensagem);
			//request.setAttribute("modelLogin", modelLogin);
			RequestDispatcher redireciona = request.getRequestDispatcher("principal/cad_usuario.jsp");
			/* seta os atributos de ModelLogin na tela */
			request.setAttribute("modelLogin", modelLogin);
			redireciona.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

}
