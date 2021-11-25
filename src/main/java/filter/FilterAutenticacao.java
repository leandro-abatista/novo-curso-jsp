package filter;

import java.io.IOException;
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

@WebFilter(urlPatterns = {"/principal/*"})/*Intercepta todas as requisi��es que vierem do projeto, ou mapeamento*/
public class FilterAutenticacao implements Filter {

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
	}

	/**
	 * Intercepta as requisi��es e as respostas do sistema
	 * Tudo que fizer no sistema vai fazer por aqui
	 * valida��o de autentica��o
	 * Dar commit e rollback de transa��oes com o banco de dados
	 * Valida e realiza o redirecionamento de p�ginas
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
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
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
