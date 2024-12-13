global class MyCallableApexClass implements Callable
{
    public Map<String, Object> input;
    public Map<String, Object> output;
    public Map<String, Object> options;
    
    /*
        inputs - arguments - List<Object> of passed in arguments
        output - result - The result of the Function being called. Supports single Object values, List<Object> or Map<String, Object>
    */
    public Object call(String action, Map<String, Object> args)
    {

        input = (Map<String, Object>)args.get('input');
        output = (Map<String, Object>)args.get('output');
        options = (Map<String, Object>)args.get('options');

        return invokeMethod(action, input, output, options);
    }

    global Boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options)
    {
        if (methodName == 'getAccountsSetValues')
        {
            output.put('result', getAccountsSetValues((List<Object>)inputs.get('arguments')));
        }
        else if (methodName == 'getAccountsRemoteAction')
        {
            output.put('result', getAccountsRemoteAction(inputs));
        }
        return true;
    }

    private List<Account> getAccountsSetValues(List<Object> arguments)
    {
        String type = (String) arguments[0];
        Integer X = Integer.valueOf(arguments[1]);

        List<Account> accs = [SELECT ID, Name FROM Account WHERE Type = :type LIMIT :X];
            
        return accs;
    }
    
    private List<Account> getAccountsRemoteAction(Map<String, Object> arguments)
    {
        String type = (String) arguments.get('type');
        Integer X = (Integer) arguments.get('limit');
        
        List<Account> accs = [SELECT ID, Name FROM Account WHERE Type = :type LIMIT :X];
            
        return accs;
    }
}