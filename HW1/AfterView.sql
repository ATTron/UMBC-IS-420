-- 35
select tenant_name from tenant where tenant_dob = (select min(tenant_dob) from tenant);