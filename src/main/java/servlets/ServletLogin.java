package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ModelLogin;

/**
 * Essa classe servlet extende do HttpServlet
 * As servlets também são controllers
 * @author leand
 *
 */
@WebServlet("/ServletLogin")/*mapeamento de URl que vem da tela*/
public class ServletLogin extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public ServletLogin() {
        super();
    }

    /*Recebe os dados da URL vindos por parâmetros*/
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/*Recebe os dados enviados por um formulário*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("nome");
		String senha = request.getParameter("idade");
		
		/*validar login e senha na página*/
		if (login != null && !login.isEmpty() && senha != null && !senha.isEmpty()) {
			
			/*instanciando o objeto ModeloLogin*/
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);
		} else {/*se não foi informado login e senha*/
			/*retorna para a mesma página*/
			RequestDispatcher redirecionar = request.getRequestDispatcher("pagina-inicial.jsp");
			request.setAttribute("msg", "Informe o Login e a Senha corretamente!");
			redirecionar.forward(request, response);
			
		}
		
		
	}

}
