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

@WebFilter(urlPatterns = {"/principal/*"})/*Intercepta todas as requisições que vierem do projeto, ou mapeamento*/
public class FilterAutenticacao implements Filter {
	
	private static Connection connection;

    /**
     *  constructor padrão
     */
    public FilterAutenticacao() {
    }

    /**
     * Encerra o processo quando o servidor é parado
     * Mata os processos de conexão com o banco de dados
     */
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Intercepta as requisições e as respostas do sistema
	 * Tudo que fizer no sistema vai fazer por aqui
	 * validação de autenticação
	 * Dar commit e rollback de transaçãoes com o banco de dados
	 * Valida e realiza o redirecionamento de páginas
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		
		try {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		//pegando o usuário logado na sessão
		String usuarioLog = (String) session.getAttribute("usuarioLogado");
		String urlParaAutenticar = req.getServletPath();/*url está sendo acessada*/
		
		/*validar se está logado, senão redireciona para a tela de login*/
		if (usuarioLog == null  &&
				!urlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin")) {
			
			RequestDispatcher redireciona = request.getRequestDispatcher("/pagina-inicial.jsp?url=" + urlParaAutenticar);
			request.setAttribute("msg", "Por favor realize o login!");
			redireciona.forward(request, response);
			return;/*para a execução e redireciona para o login*/
			
		} else {
			chain.doFilter(request, response);
		}
		
		connection.commit();/* commita a operações no banco de dados */
		
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
