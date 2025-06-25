output "alb_dns_name" {
  description = "The domain name of the ALB"
  value       = module.elb.elb_dns_name
}

# Add more outputs as needed
