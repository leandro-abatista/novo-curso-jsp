package filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import connection.SingleConnectionBanco;

@WebFilter(urlPatterns = {"/principal/*"})/*Intercepta todas as requisi��es que vierem do projeto, ou mapeamento*/
public class FilterAutenticacao implements Filter {
	
	private static Connection connection;

    /**
     *  constructor padr�o
     */
    public FilterAutenticacao() {
    }

    /**
     * Encerra o processo quando o servidor � parado
     * Mata os processos de conex�o com o banco de dados
     */
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Intercepta as requisi��es e as respostas do sistema
	 * Tudo que fizer no sistema vai fazer por aqui
	 * valida��o de autentica��o
	 * Dar commit e rollback de transa��oes com o banco de dados
	 * Valida e realiza o redirecionamento de p�ginas
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		
		try {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		//pegando o usu�rio logado na sess�o
		String usuarioLog = (String) session.getAttribute("usuarioLogado");
		String urlParaAutenticar = req.getServletPath();/*url est� sendo acessada*/
		
		/*validar se est� logado, sen�o redireciona para a tela de login*/
		if (usuarioLog == null  &&
				!urlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin")) {
			
			RequestDispatcher redireciona = request.getRequestDispatcher("/pagina-inicial.jsp?url=" + urlParaAutenticar);
			request.setAttribute("msg", "Por favor realize o login!");
			redireciona.forward(request, response);
			return;/*para a execu��o e redireciona para o login*/
			
		} else {
			chain.doFilter(request, response);
		}
		
		connection.commit();/* commita a opera��es no banco de dados */
		
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
			
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnectionBanco.getConnection();
	}

}
