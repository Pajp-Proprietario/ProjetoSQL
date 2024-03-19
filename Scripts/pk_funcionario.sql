create or replace package pk_funcionario as
    procedure pr_inserir_funcionario(p_nm_funcionario varchar2, p_vl_salario NUMBER, o_erro out varchar2);
end pk_funcionario;
/
create or replace package body pk_funcionario  as
    /*5 - Escreva um procedimento que insira um novo funcionário na tabela de funcionários, garantindo que o novo funcionário tenha um número de identificação único e válido.*/
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