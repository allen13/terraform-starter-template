# Example EC2 instances
resource "aws_instance" "app" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index % length(var.subnet_ids)]
  
  vpc_security_group_ids = var.security_group_ids
  
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }
  
  tags = merge(
    {
      Name        = "${var.environment}-app-${count.index + 1}"
      Environment = var.environment
    },
    var.tags
  )
}

# Auto Scaling Group example (commented out by default)
# resource "aws_launch_template" "app" {
#   name_prefix   = "${var.environment}-app-"
#   image_id      = var.ami_id
#   instance_type = var.instance_type
#   
#   vpc_security_group_ids = var.security_group_ids
#   
#   block_device_mappings {
#     device_name = "/dev/sda1"
#     
#     ebs {
#       volume_size           = var.root_volume_size
#       volume_type           = "gp3"
#       delete_on_termination = true
#     }
#   }
#   
#   tag_specifications {
#     resource_type = "instance"
#     
#     tags = merge(
#       {
#         Name        = "${var.environment}-app"
#         Environment = var.environment
#       },
#       var.tags
#     )
#   }
# }
# 
# resource "aws_autoscaling_group" "app" {
#   name_prefix         = "${var.environment}-app-"
#   vpc_zone_identifier = var.subnet_ids
#   min_size            = var.min_size
#   max_size            = var.max_size
#   desired_capacity    = var.desired_capacity
#   
#   launch_template {
#     id      = aws_launch_template.app.id
#     version = "$Latest"
#   }
#   
#   tag {
#     key                 = "Name"
#     value               = "${var.environment}-app-asg"
#     propagate_at_launch = true
#   }
#   
#   tag {
#     key                 = "Environment"
#     value               = var.environment
#     propagate_at_launch = true
#   }
# }