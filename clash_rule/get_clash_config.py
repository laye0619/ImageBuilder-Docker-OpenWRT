from distutils.command.config import config
import random
import yaml
import requests

RULE_PROVIDERS_FILENAME = 'loyalsoldier_providers_manual.yaml'
RULE_FILENAME = 'loyalsoldier_rules_manual.yaml'


def get_basic_part() -> dict:
    # resp = requests.get(
    #     'https://ghproxy.com/https://raw.githubusercontent.com/Hackl0us/SS-Rule-Snippet/main/LAZY_RULES/Clash_Premium.yaml')
    resp = requests.get(
        'https://raw.githubusercontent.com/Hackl0us/SS-Rule-Snippet/main/LAZY_RULES/Clash_Premium.yaml')
    config_content = yaml.safe_load(resp.text)
    config_content.pop('proxies')
    config_content.pop('proxy-groups')
    config_content.pop('proxy-providers')

    providers_dict = {}
    providers_dict['rule-providers'] = config_content['rule-providers']
    with open('./clash_rule/hackl0us_providers.yaml', 'w') as f:
        f.write(yaml.dump(providers_dict, sort_keys=False))
        f.close()

    rules_dict = {}
    rules_dict['rules'] = config_content['rules']
    rules_dict['rules'] = [x.replace(',Proxy', ',PROXY')
                           for x in rules_dict['rules']]
    with open('./clash_rule/hackl0us_rules.yaml', 'w') as f:
        f.write(yaml.dump(rules_dict, sort_keys=False))
        f.close()

    config_content.pop('rule-providers')
    config_content.pop('rules')
    return config_content


def get_proxies_and_groups_part() -> dict:
    with open('./clash_rule/my_clash_info.yaml', 'r') as f:
        my_config = yaml.safe_load(f)
        f.close()
    # 随机生成0-9数字，填充端口号
    port_last_number = random.randint(1, 9)
    for item in my_config['proxies']:
        item['port'] = int(float(item['port'])/10)*10+port_last_number
    return my_config


def get_rules_part(filename: str) -> dict:
    with open('./clash_rule/'+filename, 'r') as f:
        my_config = yaml.safe_load(f)
        f.close()
    with open('./clash_rule/my_clash_rules.yaml', 'r') as f:
        my_rules_config = yaml.safe_load(f)
        f.close()
    my_config['rules'] = my_rules_config['rules'] + my_config['rules']
    return my_config


def get_rule_providers_part(filename: str) -> dict:
    with open('./clash_rule/'+filename, 'r') as f:
        my_config = yaml.safe_load(f)
        f.close()
    return my_config


my_clash_config = get_basic_part()
my_clash_config.update(get_proxies_and_groups_part())
my_clash_config.update(get_rule_providers_part(RULE_PROVIDERS_FILENAME))
my_clash_config.update(get_rules_part(RULE_FILENAME))
with open('./clash_rule/my_clash_config.yaml', 'w') as f:
    f.write(yaml.dump(my_clash_config, sort_keys=False))
    f.close()
