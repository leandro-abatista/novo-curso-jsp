package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.If;

import dao.DAOLoginRepository;
import dao.DAOUsuarioRepository;
import model.ModelLogin;

/**
 * Essa classe servlet extende do HttpServlet As servlets também são controllers
 * 
 * @author leand
 *
 */
@WebServlet(urlPatterns = { "/principal/ServletLogin", "/ServletLogin" }) /* mapeamento de URl que vem da tela */
public class ServletLogin extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private DAOLoginRepository repository = new DAOLoginRepository();
	private DAOUsuarioRepository usuarioRepository = new DAOUsuarioRepository();

	public ServletLogin() {
		super();
	}

	/* Recebe os dados da URL vindos por parâmetros */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String acao = request.getParameter("acao");
		if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("logout")) {
			request.getSession().invalidate();// invalida a sessão
			RequestDispatcher redirecionar = request.getRequestDispatcher("pagina-inicial.jsp");
			request.setAttribute("msgLogout", "Usuário deslogado com sucesso!");
			redirecionar.forward(request, response);
		} else {

			/* resolve o problema para a tela na ficar em branco */
			doPost(request, response);
		}
	}

	/* Recebe os dados enviados por um formulário */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String url = request.getParameter("url");

		try {
			/* validar login e senha na página */
			if (login != null && !login.isEmpty() && senha != null && !senha.isEmpty()) {

				/* instanciando o objeto ModeloLogin */
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setLogin(login);
				modelLogin.setSenha(senha);

				if (repository.validarAutenticacao(modelLogin)) {
					
					modelLogin = usuarioRepository.consultaUsuarioLogado(login);

					/* esse código pega o usuário logado na sessão */
					request.getSession().setAttribute("usuarioLogado", modelLogin.getLogin());
					
					/*verifica se esse login é administrador*/
					request.getSession().setAttribute("perfil", modelLogin.getPerfil());
					
					
					if (url == null || url.equals("null")) {
						url = "principal/principal.jsp";
					}

					RequestDispatcher redirecionar = request.getRequestDispatcher(url);
					request.setAttribute("msgLogado", "Usuário autênticado com sucesso!");
					redirecionar.forward(request, response);

				} else {/* se não foi informado login e senha */
					/* retorna para a mesma página */
					RequestDispatcher redirecionar = request.getRequestDispatcher("/pagina-inicial.jsp");
					request.setAttribute("msg", "Informe o Login e a Senha corretamente!");
					redirecionar.forward(request, response);

				}

			} else {/* se não foi informado login e senha */
				/* retorna para a mesma página */
				RequestDispatcher redirecionar = request.getRequestDispatcher("pagina-inicial.jsp");
				request.setAttribute("msg", "Informe o Login e a Senha corretamente!");
				redirecionar.forward(request, response);

			}

		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}

	}

}
