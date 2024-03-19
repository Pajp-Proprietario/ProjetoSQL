create or replace package pk_funcionario as
    procedure pr_inserir_funcionario(p_nm_funcionario varchar2, p_vl_salario NUMBER, o_erro out varchar2);
end pk_funcionario;
/
create or replace package body pk_funcionario  as
    /*5 - Escreva um procedimento que insira um novo funcion�rio na tabela de funcion�rios, garantindo que o novo funcion�rio tenha um n�mero de identifica��o �nico e v�lido.*/
    procedure pr_inserir_funcionario(p_nm_funcionario varchar2, p_vl_salario NUMBER, o_erro out varchar2) is
    begin
        insert into tb_funcionario 
        (cd_funcionario,
         nm_funcionario,
         vl_salario
        )values
        (sq_cd_funcionario.nextval,
         p_nm_funcionario, 
         p_vl_salario);
    exception
        when others then
            o_erro := sqlerrm;
    end;    
end pk_funcionario;